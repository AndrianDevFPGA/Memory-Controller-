/*
  Name : Rakotojaona Nambinina
  email : Andrianoelisoa.Rakotojaona@gmail.com
  Description : Controller for memory 
*/

`timescale 1ns / 1ps


`timescale 1ns / 1ps

module aisim(
             clk,
             rst,
             ev,
             context,
             scheduleOut,
             tx
             );
  input clk;
  input rst;
  input ev;
  input [31:0] context;
  
  output reg tx;
  output reg [31:0] scheduleOut; 
  
  integer state ;
  integer count ;
  
  always @ (posedge clk)
    begin
      if (rst)
        begin
          state <= 0;
          tx <= 0;
          scheduleOut <= 32'dx;
          count <= 0;
        end 
      else
        begin
          case (state)
            0:
              begin
                if (ev)
                  begin
                    state <= 1;
                    counter <= 0;
                  end 
              end
            
            1:
              begin
                if (counter < 4)
                  begin
                    state <= 1;
                  end 
                else
                  begin
                    state <=0;
                    counter <= 0;
                  end
              end 
          endcase
        end 
    end 
  
  always @ (negedge clk)
    begin
      case (state)
        0:
          begin
            tx <= 0;
            scheduleOut <=32'dx;
          end 
        1:
          begin
            // select right schedule
            if (context[31:29] == 3'b001)
              begin
                tx <= 1;
                scheduleOut <= 32'b00000000111110111010000000100000;
              end 
            else if  (context[31:29] == 3'b010)
              begin
                tx <= 1;
                scheduleOut <= 32'b00000000001111111010000000100000;
              end 
            else if (context[31:29]  == 3'b100)
              begin
                tx <= 1;
                scheduleOut <= 32'b00000000001110111010000000100000;
              end
            else 
              begin
                tx <= 0;
                scheduleOut <= 32'dx;
              end 
          end 
      endcase
    end 
  
endmodule


/*

module tbAisim(
    );
    
  reg clk;
  reg rst;
  reg ev;
  reg [31:0] context;
  
  wire  tx;
  wire  [31:0] scheduleOut; 
    aisim uut(
             clk,
             rst,
             ev,
             context,
             scheduleOut,
             tx
             );
  initial
    begin
      clk =0;
      rst = 1;
      ev = 0;
      context = 32'b00100001000010000100001000010000;
      #10
      rst = 0;
      #50
      ev = 1;
      context = 32'b00100001000010000100001000010000;
      #100
      context = 32'b01000001000010000100001000010000;
       #100
      context = 32'b10000001000010000100001000010000;
        #100
        context = 32'b00000001000010000100001000010000;
      #300
      ev = 0;
    end
  
  always 
    begin
      #5 clk = ! clk;
    end 
  
  
endmodule


*/
