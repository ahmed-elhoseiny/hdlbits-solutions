module top_module( 
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out );

// assign out = in[sel*4+3:sel*4];
// Why in[ sel*4+3 : sel*4 ] fails Even though logically this looks correct 
// (selecting 4 bits starting at sel*4), the synthesizer often complains 
// with an error like “is not a constant”. That’s because it can’t guarantee 
// at compile time that the slice width is fixed 
// — even though you know it’s always 4 bits.
    
    assign out = in[sel*4 +: 4];
    // +: means “take 4 bits starting from this index and going upward.”
    // (selecting 4 bits starting at sel*4)
    // This syntax makes it explicit that the width is constant (4 bits), 
    // so the synthesizer is happy.

//__________________________________________________________________________

	// We can't part-select multiple bits without an error, but we can select one bit at a time,
	// four times, then concatenate them together.
    
//	assign out = {in[sel*4+3], in[sel*4+2], in[sel*4+1], in[sel*4+0]};

	// Alternatively, "indexed vector part select" works better, but has an unfamiliar syntax:
	// assign out = in[sel*4 +: 4];		// Select starting at index "sel*4", then select a total width of 4 bits with increasing (+:) index number.
	// assign out = in[sel*4+3 -: 4];	// Select starting at index "sel*4+3", then select a total width of 4 bits with decreasing (-:) index number.
	// Note: The width (4 in this case) must be constant.

endmodule