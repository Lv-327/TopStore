use TopStore
GO
IF OBJECT_ID ('spLOG') IS NOT NULL
DROP PROCEDURE spLOG

GO
CREATE PROCEDURE spLOG 
	@in int = 0, @up int = 0 
	,@dl int = 0, @ProcedName nvarchar(50) ='input sp name' 
	,@TableName nchar(30) = 'input table name' 
	,@Action nvarchar(10)
	,@LogKey datetime2
as
--insert row to Log table
BEGIN
	SET NOCOUNT ON
		IF @Action = 'Start'  
			BEGIN
				INSERT INTO LogProcessesTable
					(StateDescription
					,UserName
					,StartTime
					,ProcessName
					,TableName
					,InsertRows
					,UpdateRows
					,DeleteRows
					,LogKey)

				Values (@Action
				,SYSTEM_USER
				,getdate()
				,@ProcedName
				,@TableName
				,@in
				,@up
				,@dl
				,@LogKey
				)
--update row in Log table			
			END
		If @Action = 'Stop' 
			BEGIN
				update LogProcessesTable
					SET EndTime=getdate()
					,StateDescription = @Action
					,InsertRows = @in
					,UpdateRows = @up
					,DeleteRows= @dl
					,Report = 'Done!'
					WHERE @LogKey=LogKey							
			END 
--update row in Log table with error	
		If @Action = 'Error' 
			BEGIN
				update LogProcessesTable
					SET EndTime=getdate()
					,StateDescription = @Action
					,Report = CAST(ERROR_NUMBER() AS nvarchar(10))+' '+ ERROR_MESSAGE()
					WHERE @LogKey=LogKey
					declare @error_message nvarchar(2000)
					set @error_message=ERROR_MESSAGE()
					RAISERROR  (@error_message, 16, -1)
			end					
	SET NOCOUNT OFF
END
GO
