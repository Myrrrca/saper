

saper: saper.S
	gcc -m32 -g saper.S -o saper -z noexecstack

clean:
	rm -f saper
