SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [ifc].[proc_inserta_checada_validada]
	@id char(36),
	@verbose bit = 0
as begin
	
	begin try
		begin transaction 
			declare @codigo_dad int, 
					@checada_src datetime,
					@checada_ant datetime,  
					@tipo_ant bit,
					@tipo_src bit,
					@dispositivo nvarchar(64),
					@codigo_src int, 
					@codigo_des char(36),
					@id_interface char(36),
					@id_regla char(36),
					@comentarios nvarchar(128),
					@id_destino char(36),
					@access bit,
					@dn char(2),
					@vw nvarchar(128)
			
			set @vw = 'ifc.vw_checadas_morpho'

			if (exists (select id_source from ifc.handpunch where id_source = @id) 
				and (select id_source from ifc.handpunch where id_source = @id) is not null) begin 
				print 'Procesado previamente...'
				
			end else begin 

				----------------------------------------------------------
				if @verbose = 1 set nocount off else set nocount on
				----------------------------------------------------------
				select @id_interface = 	id_interface 
				from ifc.interface where [_interface_name] = 'handpunch';
				----------------------------------------------------------

				exec ifc.proc_obtener_datos_checada_by_id  
					 @in_id = @id
					,@in_vw = @vw
					,@out_checada_src = @checada_src OUTPUT
					,@out_dispositivo = @dispositivo OUTPUT
					,@out_codigo_src = @codigo_src OUTPUT
					,@out_access = @access OUTPUT
					,@out_dn = @dn OUTPUT

				if (exists(select id_checada from tra.vw_checadas with (nolock)
						where _alter_id = @codigo_src and _checada = @checada_src )) begin 
		
					select @id_regla = id_regla from ifc.reglas
					where id_interface = @id_interface and _code = 'NE';
					insert into ifc.handpunch(id_source,_codigo_src,_codigo_des,_checada,id_regla,_subio, id_destino, _comentarios,_tipo, _jornada, _SE,_ES,_EE,_dispositivo,_dn)
					values (@id, @codigo_src, @codigo_des, @checada_src,@id_regla, 0, null, 'No Sube [ES]: ', 'N',datediff(MINUTE,@checada_ant,@checada_src)/60.0, null, null,null, @dispositivo, @dn );
					print 'Procesado previamente...'
					
				end else begin
	
					--verifico que el codigo de empleado exista en todos los sistemas
	
					select @codigo_des = employee_id from cat.employees with (nolock)
					where _alter_id = @codigo_src;

					----------------------------------------------------------
					-- Para validaciones
					----------------------------------------------------------
					if @verbose = 1 select @codigo_dad[DAD],@codigo_src [SRC], @codigo_des [DES], @access [AC], @dispositivo [DO];
					----------------------------------------------------------
	
					if(@access = 1) begin
						print 'Acceso denegado en dispositivo..['+@dispositivo+']['+rtrim(isnull(@codigo_src, '-'))+ ']'
						select @id_regla = id_regla from ifc.reglas
						where id_interface = @id_interface and _code = 'NE';
						insert into ifc.handpunch(id_source,_codigo_src,_codigo_des,_checada,id_regla,_subio, id_destino, _comentarios)
						values (@id, @codigo_src, @codigo_des, @checada_src, @id_regla, 0, null, 'Acceso denegado en dispositivo ['+@dispositivo+']');
						commit transaction
						return;
					end;

					if(@codigo_des is null or @codigo_src is null) begin
						print 'Error en el Numero de Colaborador... [' + rtrim(isnull(@codigo_des, '-')) + ']['+rtrim(isnull(@codigo_src, '-'))+ ']'
						select @id_regla = id_regla from ifc.reglas
						where id_interface = @id_interface and _code = 'NE';
						insert into ifc.handpunch(id_source,_codigo_src,_codigo_des,_checada,id_regla,_subio, id_destino, _comentarios)
						values (@id, @codigo_src, @codigo_des, @checada_src, @id_regla, 0, null, 'No sube [NE]');
						commit transaction
						return;
					end;
					----------------------------------------------------------
					select top 1 
						@checada_ant = _checada
						,@tipo_ant = _tipo
					from tra.vw_checadas with (nolock) where 
						_alter_id = @codigo_src
						and _checada <= dateadd(minute,15,@checada_src)
					order by _checada desc
	
	
					declare @checadaSE datetime 	
					exec ifc.[proc_get_regla_checada] @code = 'SE', @checada_in = @checada_ant, @result = @checadaSE OUTPUT
	

					declare @checadaES datetime 	
					exec ifc.[proc_get_regla_checada] @code = 'ES', @checada_in = @checada_ant, @result = @checadaES OUTPUT
	

					declare @checadaEE datetime 	
					exec ifc.[proc_get_regla_checada] @code = 'EE', @checada_in = @checada_ant, @result = @checadaEE OUTPUT
	
					if @verbose = 1 select @checadaSE SE, @checadaES ES, @checadaEE EE
					----------------------------------------------------------
					-- Para validaciones
					----------------------------------------------------------
					if (@checada_ant is null) begin set @checada_ant = @checada_src end;
					if @verbose = 1 select  @checada_src [SRC], 
											@tipo_ant [TA],
											datediff(MINUTE,@checada_ant,@checada_src)/60.0 [JO],
											@checada_ant [ANT], 
											@checadaSE [SE],
											@checadaES [ES],
											@checadaEE [EE],
											@comentarios [CO]
								
					----------------------------------------------------------
					declare @idt table (_id char(36))
					declare @id_jornada char(36)
					if ((@tipo_ant = 1 and @checada_src > @checadaSE) or @tipo_ant is null) begin
						print 'Sube como Entrada...';

						-- inserto en checa2
						insert into tra.checadas (employee_id, _checada, _checada_fecha, _checada_hora, _dispositivo_code, _tipo , _sync)
						output inserted.id_checada into @idt
						values	(@codigo_des, @checada_src, @checada_src, @checada_src, @dispositivo, 0,0);

						select @id_destino = _id from @idt;		

						select @id_regla = id_regla from ifc.reglas
						where id_interface = @id_interface and _code = 'SE';

						--inserto en tabla handpunch como EE
						insert into ifc.handpunch(id_source,_codigo_src,_codigo_des,_checada,id_regla,_subio, id_destino, _comentarios,_tipo, _jornada, _SE,_ES,_EE,_dispositivo,_dn)
						values (@id,@codigo_src,@codigo_des,@checada_src, @id_regla, 1, @id_destino, 'Sube como entrada [SE] ' , 'E',datediff(MINUTE,@checada_ant,@checada_src)/60.0, @checadaSE, @checadaES,@checadaEE, @dispositivo, @dn );
		
		
						exec [tra].[proc_send_checada_to_jornadas] @id_destino, @dispositivo,@codigo_des, @checada_src, 0, 0, @id_jornada OUTPUT
						exec [tra].[proc_send_jornada_to_lista] @id_jornada
						commit transaction
						return;
					end; 

					if (@tipo_ant = 0 and @checada_src > @checadaES and @checada_src < @checadaEE) begin
						print 'Sube como Salida...';

						-- inserto en checa2
						insert into tra.checadas (employee_id, _checada, _checada_fecha, _checada_hora, _dispositivo_code, _tipo , _sync)
						output inserted.id_checada into @idt
						values	(@codigo_des, @checada_src, @checada_src, @checada_src, @dispositivo, 1,0);

						--Obtengo el id_destino  de checa2
						select @id_destino = _id from @idt;	

						select @id_regla = id_regla from ifc.reglas
						where id_interface = @id_interface and _code = 'ES';

						--inserto en tabla handpunch como EE
						insert into ifc.handpunch(id_source,_codigo_src,_codigo_des,_checada,id_regla,_subio, id_destino, _comentarios,_tipo, _jornada, _SE,_ES,_EE,_dispositivo,_dn)
						values (@id,@codigo_src,@codigo_des,@checada_src, @id_regla, 1, @id_destino ,'Sube como Salida [ES]' , 'S',datediff(MINUTE,@checada_ant,@checada_src)/60.0, @checadaSE, @checadaES,@checadaEE, @dispositivo, @dn );
		
		
						exec [tra].[proc_send_checada_to_jornadas] @id_destino, @dispositivo,@codigo_des, @checada_src, 1, 0, @id_jornada OUTPUT
						exec [tra].[proc_send_jornada_to_lista] @id_jornada
						commit transaction
						return;
					end else begin
						if (@tipo_ant = 0  and @checada_src > @checadaEE) begin
							print 'Sube como Entrada...';

							-- inserto en checa2
							insert into tra.checadas (employee_id, _checada, _checada_fecha, _checada_hora, _dispositivo_code, _tipo , _sync)
							output inserted.id_checada into @idt
							values	(@codigo_des, @checada_src, @checada_src, @checada_src, @dispositivo, 0,0);

							--Obtengo el id_destino  de checa2
							select @id_destino = _id from @idt;	

							-- Obtengo el id de la regla aplicada
							select @id_regla = id_regla from ifc.reglas
							where id_interface = @id_interface and _code = 'EE';

							--inserto en tabla handpunch como EE
							insert into ifc.handpunch(id_source,_codigo_src, _codigo_des,_checada,id_regla,_subio, id_destino, _comentarios,_tipo, _jornada, _SE,_ES,_EE,_dispositivo,_dn)
							values (@id, @codigo_src, @codigo_des,@checada_src, @id_regla, 1, @id_destino, 'Sube como entrada [EE]', 'E',datediff(MINUTE,@checada_ant,@checada_src)/60.0, @checadaSE, @checadaES,@checadaEE, @dispositivo, @dn );
			
							exec [tra].[proc_send_checada_to_jornadas] @id_destino, @dispositivo,@codigo_des, @checada_src, 0, 0, @id_jornada OUTPUT
							exec [tra].[proc_send_jornada_to_lista] @id_jornada
							commit transaction
							return;
						end else begin
							print 'No Sube...';

							-- Obtengo el id de la regla aplicada
							select @id_regla = id_regla from ifc.reglas
							where id_interface = @id_interface and _code = 'ES';

							--inserto en tabla handpunch como no sube
							insert into ifc.handpunch(id_source,_codigo_src, _codigo_des,_checada,id_regla,_subio, id_destino, _comentarios,_tipo, _jornada, _SE,_ES,_EE,_dispositivo,_dn)
							values (@id, @codigo_src,@codigo_des ,@checada_src,@id_regla, 0, null, 'No Sube [ES]: ', 'N',datediff(MINUTE,@checada_ant,@checada_src)/60.0, @checadaSE, @checadaES,@checadaEE, @dispositivo, @dn );
			
							commit transaction
							return;
						end;	
						commit transaction
						return;
					end;
				end;
			end;
		commit transaction	
	end try
	begin catch
		rollback transaction
		declare	  @txt nvarchar(max)
				, @date nvarchar(23) 
				, @sub nvarchar(max)
		set @date = convert(varchar, getdate() ,121) 
		
		set @txt =  'Errores detecados en la ejecucion del SP [ifc].[proc_inserta_checada_validada]'; 
		set @txt = @txt + CHAR(13)+CHAR(10)+'	* Error: 	' + convert(nvarchar(max),ERROR_MESSAGE()); 
		set @txt = @txt + CHAR(13)+CHAR(10)+'	* Date: 	' + @date;
		set @txt = @txt + CHAR(13)+CHAR(10)+'	* ID: 	' + @id;
		set @txt = @txt + CHAR(13)+CHAR(10)+'	* SP: 	' + ERROR_PROCEDURE();
		set @sub = '[IFC][Time.io][Errores]['+@date+'][ifc].[proc_inserta_checada_validada]'
		EXEC msdb.dbo.sp_send_dbmail  
			@profile_name = 'RelayRiviera',  
			@recipients = 'rsanchez@rcdhotels.com',  
			@body = @txt,
			@subject =  @sub;
	end catch
end;
GO
