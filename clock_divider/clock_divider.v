module clock_divider (
	input reg CLK_IN,
	output reg CLK_VAR,
	input reg RST
);

//	Clock division counter
reg	[15:0]	CLK_DIV;
// Parameters for in/out freq
parameter	CLK_IN_FREQ		=	50000000;	//	Change to match input clock
parameter	CLK_VAR_FREQ	=	20000	;		//	Change to match output clock

always @ (posedge CLK_IN) // i2c clock gen
begin
	if(RST)
	begin
		CLK_VAR	<=	0;
		CLK_DIV	<=	0;
	end
	else
	begin
		if( CLK_DIV	< (CLK_IN_FREQ/CLK_VAR_FREQ) )
			CLK_DIV	<=	CLK_DIV+1'b1;
		else
		begin
			CLK_DIV	<=	0;
			CLK_VAR	<=	~CLK_VAR;
		end
	end
end

endmodule