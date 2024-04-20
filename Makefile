
saper: saper.S 
	gcc -m32 -g saper.S ./src/update_field.S ./src/write_cursor_location.S ./src/print/print_real_field_text.S ./src/print/print_instructions.S ./src/print/print_newline.S  ./src/print/print_space.S ./src/render_field.S ./src/check_field.S -o saper -z noexecstack

clean:
	rm -f saper
