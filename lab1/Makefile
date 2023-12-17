output_name = force_regs.random.ucli

$(output_name): force_regs.ucli
	awk 'BEGIN{srand();}{if ($$1 != "") { print $$1,$$2,$$3,int(rand()*2)}}' $< > $@

<<<<<<< HEAD
foo.txt: $(output_name)
	touch $(output_name) > $@

clean:
	rm -f $(output_name) foo.txt
=======
clean:
	rm -f $(output_name)
>>>>>>> bcd7c9b (rename lab 0 to lab 1)
