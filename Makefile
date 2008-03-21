exe=arc.exe

SCM_SOURCES = arc-exe-init.scm ac.scm brackets.scm bitops.scm

$(exe): arc-exe.scm $(SCM_SOURCES)
	mzc --exe $@ $<

# We need to delete the .arcc files because the ABI is not stable yet,
# and they may have some nasty leftovers. See:
#
# http://www.owlnet.rice.edu/~comp210/Handouts/SchemeTips.html

clean:
	-rm $(exe) *.arcc

test check: $(exe)
	# This is not very meaningful because it is too wordy. Better run it
	# using runprove. See runtest here.
	find t/ -type f   -name '*.arc.t' -exec ./$(exe) {} ';'
	find t/ -type f -name '*.t' ! -name '*.arc.t' -print0 | xargs -0 prove --nocolor

runtest runcheck: $(exe)
	bash Test.sh --exe

.PHONY: clean check test runtest runcheck
