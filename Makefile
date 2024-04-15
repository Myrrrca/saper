

saper: saper.S 
	gcc -m32 -g saper.S ./src/print/print_instructions.S ./src/print/print_newline.S  ./src/print/print_space.S ./src/render_field.S ./src/check_field.S -o saper -z noexecstack

clean:
	rm -f saper
