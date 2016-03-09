# Define all your usual stuff.  This could come from 'configure'
CC = g++ --std=c++11 -I. 

# where is this program
TESTGEN = bin/cxxtestgen

# name your tests corresponds to foobar_test.h, dingbat_test.h
TESTS = foobar dingbat
#-----------------------------------------
# should not need to modify

.PHONY: test
test: $(TESTS)
        @(for i in $(TESTS); do ./$$i; done)

all: test

TESTS_H = $(TESTS:=_test.h)
TESTS_CC = $(TESTS:=_test.cc)

$(TESTS): $(TESTS_CC)

%_test.cc : test_%.h
        $(TESTGEN) --error-printer -o $@ $<

%: %_test.cc
        $(CC) -o $@ $< 

clean:
        -rm -f *~
        -rm -f core*
        -rm -f $(TESTS) $(TESTS_CC)


