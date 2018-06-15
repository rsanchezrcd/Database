SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
  CREATE function cat.func_split(
	 @string nvarchar(max)
	,@delimiter nchar(1)
  )returns @parts table(_part nvarchar(1024))
  as begin
	if @string is null return
	declare @iStart int,
			@iPos int
	if substring( @string, 1, 1 ) = @delimiter 
	begin
		set @iStart = 2
		insert into @parts
		values( null )
	end
	else 
		set @iStart = 1
	while 1=1
	begin
		set @iPos = charindex( @delimiter, @string, @iStart )
		if @iPos = 0
			set @iPos = len( @string )+1
		if @iPos - @iStart > 0          
			insert into @parts
			values  (ltrim(rtrim(substring( @string, @iStart, @iPos-@iStart ))))
		else
			insert into @parts
			values( null )
		set @iStart = @iPos+1
		if @iStart > len( @string ) 
			break
	end
	RETURN
  end;


GO
