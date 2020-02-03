USE BillingCollection
GO

CREATE FUNCTION getExtraCharge (
	@consump float,
	@ctype int
)
RETURNS float
AS
BEGIN
	RETURN
		(SELECT 
			SUM(wr.Rate * (@consump - wr.Cons_from))
		FROM 
			WaterRates wr
		WHERE
			wr.C_Type = @ctype AND
			@consump BETWEEN wr.Cons_from AND wr.Cons_to)
END
GO