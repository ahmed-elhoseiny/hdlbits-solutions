module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q ); 
reg [3:0] sumer;
reg [255:0] q_state;
integer i,k;

always @(posedge clk ) begin
    if (load) begin
        q<= data;
    end else begin
        q<= q_state;
    end
end


always @(*) begin
   for ( i = 0; i<=255 ; i=i+1 ) begin
        if (i<=14 && i>=1) begin 
            sumer = {3'b000, q[i+239]} + {3'b000, q[i+240]} + {3'b000, q[i+241]} +
                    {3'b000, q[i-1]}   +                      {3'b000, q[i+1] }  +
                    {3'b000, q[i+15]}  + {3'b000, q[i+16]}  + {3'b000, q[i+17]}  ;
        end else if (i<=254 && i>=241) begin
            sumer = {3'b000, q[i-17]}  + {3'b000, q[i-16]}  + {3'b000, q[i-15]} +
                    {3'b000, q[i-1]}   +                      {3'b000, q[i+1] } +
                    {3'b000, q[i-241]} + {3'b000, q[i-240]} + {3'b000, q[i-239]} ;
        end else if (i==0 || i==15 || i==240 || i==255 ) begin
            if (i==0) begin
                sumer = {3'b000, q[255]} + {3'b000, q[240]} + {3'b000, q[241]}  +
                        {3'b000, q[15]}  +                    {3'b000, q[i+1] } +
                        {3'b000, q[31]} + {3'b000, q[i+16]} + {3'b000, q[i+17]} ;
            end else if (i==15) begin
                sumer = {3'b000, q[254]}  + {3'b000, q[255]}  + {3'b000, q[240]} +
                        {3'b000, q[i-1]}  +                     {3'b000, q[0] }  +
                        {3'b000, q[i+15]} + {3'b000, q[i+16]} + {3'b000, q[16]}  ;
            end else if (i==240) begin
                sumer = {3'b000, q[239]} + {3'b000, q[i-16]} + {3'b000, q[i-15]} +
                        {3'b000, q[255]} +                     {3'b000, q[i+1] } +
                        {3'b000, q[15]}  + {3'b000, q[0]}    + {3'b000, q[1]}    ;
            end else if (i==255) begin
                sumer = {3'b000, q[i-17]} + {3'b000, q[i-16]} + {3'b000, q[224]} +
                        {3'b000, q[i-1]}  +                     {3'b000, q[240]} +
                        {3'b000, q[14]}   + {3'b000, q[15]}   + {3'b000, q[0]}   ;
            end 
        end else if ((i>=16) && i%16 == 0) begin 
            sumer = {3'b000, q[i-1]}  + {3'b000, q[i-16]} + {3'b000, q[i-15]} +
                    {3'b000, q[i+15]} +                     {3'b000, q[i+1] } +
                    {3'b000, q[i+31]} + {3'b000, q[i+16]} + {3'b000, q[i+17]} ;

        end else if ((i>=31) && ((i-15)%16 == 0)) begin
            sumer = {3'b000, q[i-17]} + {3'b000, q[i-16]} + {3'b000, q[i-31]} +
                    {3'b000, q[i-1]}  +                     {3'b000, q[i-15] } +
                    {3'b000, q[i+15]} + {3'b000, q[i+16]} + {3'b000, q[i+1]} ;
        end else begin
            sumer = {3'b000, q[i-17]} + {3'b000, q[i-16]} + {3'b000, q[i-15]} +
                    {3'b000, q[i-1]}  +                     {3'b000, q[i+1] } +
                    {3'b000, q[i+15]} + {3'b000, q[i+16]} + {3'b000, q[i+17]} ;
        end
   q_state[i] = (sumer==4'd3) ? 1'b1:
                (sumer==4'd2) ? q[i]:1'b0  ;
   end 
end
endmodule


/* 
module rule (
    input [7:0] neigh,
    input current,
    output next );

    wire [2:0] pop;
    assign pop = {2'b00, neigh[0]} +
                 {2'b00, neigh[1]} +
                 {2'b00, neigh[2]} +
                 {2'b00, neigh[3]} +
                 {2'b00, neigh[4]} +
                 {2'b00, neigh[5]} +
                 {2'b00, neigh[6]} +
                 {2'b00, neigh[7]}; 
    
    reg tmp;
    assign next = tmp;

    always @(*) begin
        case (pop)
            2: tmp = current;
            3: tmp = 1;
            default: tmp = 0;
        endcase
    end
endmodule

module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q ); 
	
    wire [255:0] next;
    
    genvar x, y;
    generate
        for (x=0; x<=15; x=x+1) begin : gen_x
            for (y=0; y<=15; y=y+1) begin : gen_y
                rule fate (
                    .neigh({q[(x==0 ? 15 : x-1) + (y==0 ? 15 : y-1)*16],
                            q[(x==0 ? 15 : x-1) + y                *16],
                            q[(x==0 ? 15 : x-1) + (y==15 ? 0 : y+1)*16],
                            q[x                 + (y==0 ? 15 : y-1)*16],
                            q[x                 + (y==15 ? 0 : y+1)*16],
                            q[(x==15 ? 0 : x+1) + (y==0 ? 15 : y-1)*16],
                            q[(x==15 ? 0 : x+1) + y                *16],
                            q[(x==15 ? 0 : x+1) + (y==15 ? 0 : y+1)*16]}),
                    .current(q[(x + y*16)]),
                    .next(next[(x + y*16)])
                );
            end
        end
    endgenerate
    
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= next;
        end
    end
endmodule
 */