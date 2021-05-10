# Makayla Miles
# mam816

# preserves a0, v0
.macro print_str %str
	# DON'T PUT ANYTHING BETWEEN .macro AND .end_macro!!
	.data
	print_str_message: .asciiz %str
	.text
	push a0
	push v0
	la a0, print_str_message
	li v0, 4
	syscall
	pop v0
	pop a0
.end_macro

# -------------------------------------------
.eqv ARR_LENGTH 5
.data
	arr: .word 100, 200, 300, 400, 500
	message: .asciiz "testing!"
.text
# -------------------------------------------
.globl main
main:
 
          jal input_arr
          jal print_arr
          jal print_chars
          jal exit

# -------------------------------------------

          input_arr:
             # code here
           
             li t0, 0
                _loop_input:
              
                     print_str "Please enter value: "
                     li v0, 5
                     syscall
                     la t1, arr
                     mul t2, t0, 4
                     add t1, t1, t2
                     move t2, v0
                     sw t2, (t1)                                 
                     add t0, t0, 1
                     blt t0, ARR_LENGTH, _loop_input 
                
             jr ra
             
          print_arr:
             # code here
             
             li t0, 0
             _loop:
                 print_str "arr["
                 move a0, t0
                 li v0, 1
                 syscall
                 print_str "] = "
                 la t1, arr
                 mul t2, t0, 4
                 add t1, t1, t2
                 lw t2, (t1)
                 move a0, t2
                 li v0, 1
                 syscall
                print_str "\n"
                 add t0, t0, 1  
                 blt t0, ARR_LENGTH, _loop
            
             jr ra
            
          print_chars: 
             # code here
              
               la t0, message
               
               _loop_char:
                     bne t0, 0, _not_0
                     
               _not_0:
                     lb a0, (t0)
                     li v0, 11
                     syscall
                     beq a0, 0, _break
                     add t0, t0, 1
                     li a0, '\n'
                     li v0, 11
                     syscall
                     j _loop_char
                    
                        
          jr ra
          
          
	     
 
_break:
       jr ra
       
exit:
             li v0, 10
	     syscall
	     jr ra
