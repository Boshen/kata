My programming practices
------------------------

* [euler](http://projecteuler.net/)
* [codingdojo](http://codingdojo.org/cgi-bin/wiki.pl?KataCatalogue)
* [timus](http://acm.timus.ru/)

It seems scala is not a good language for programming competitions:
1. compile time is too slow - code writing time need to be maximised during competitions, thus we can not wait for that extra compilation time
2. execution time and memory usage is non-deterministic if functional style is used. For example, the [Revere Root](http://acm.timus.ru/problem.aspx?space=1&num=1001) from timus, the execution time ranges from 0.781 to 1.921 and the memory usage are all above 11308KB. In the meanwhile all C solutions are below 0.203/2192KB, all python solutions are below 1.031/11286KB.

