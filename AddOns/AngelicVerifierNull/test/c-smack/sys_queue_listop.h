/*
 * Copyright (c) 2014, Geono Kim
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 * 
 * Redistributions of source code must retain the above copyright notice, this
 * list of conditions and the following disclaimer.
 * 
 * Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation
 * and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */


/*
 * Generic singly linked list using sys/queue.h
 *
 * 		
 *   LIST_DEL	( listelm, elem, field )
 *		
 *		- delete an element of the list 		
 * 		@ listelm		:  list
 * 		@ elem			:  a target element to be deleted
 * 		@ field			:  the name of the list entry
 * 		
 * 		
 *   LIST_CLEAR	( listelm, entry_type, field )
 * 		
 *		- clear out the whole list elements
 * 		@ listelm		:  list
 * 		@ entry_type		:  the type of the entry structure
 * 		@ field			:  the name of the list entry
 * 		
 * 		
 *   LIST_SORT	( listelm, entry_type, field, cmp_func )
 * 		
 *		- list heap sort by 'data_name'
 * 		@ listelm		:  list
 * 		@ entry_type		:  the type of the entry structure
 * 		@ field			:  the name of the list entry
 * 		@ cmp_func		:  the name of the compare function to be used in sort
 *					: 		
 * 					:  int cmp_func( entry_type *a, entry_type *b )
 * 					:  The comparison function must return a negative value if
 *					:  @a should sort before @b, and a positive value if @a should sort
 *					:  after @b. If @a and @b are equivalent, and their original
 *					:  relative ordering is to be preserved, @cmp_func must return 0.
 * 		
 * 		
 *   LIST_EXISTS( listelm, entry_type, field, data_name, search_for, result_entry )
 * 		
 *		- find the list element with a certain data and put the element to 'result_entry'
 * 		@ listelm		:  list
 * 		@ entry_type		:  the type of the entry structure
 * 		@ field			:  the name of the list entry
 * 		@ data_name		:  the name of the data entry
 * 		@ search_for		:  the data which is expected to be found
 * 		@ result_entry		:  &entry structure to use as a result
 * 		
 * 		
 *   LIST_PRINT	( listelm, entry_type, field, print_func )
 * 		
 *		- find the list element with a certain data and put the element to 'result_entry'
 * 		@ listelm		:  list
 * 		@ entry_type		:  the type of the entry structure
 * 		@ field			:  the name of the list entry
 * 		@ print_func		:  the name of the print function to be used 
 *					: 		
 * 					:  void print_func( entry_type *a )
 * 					:  The print function should print the notable element in the list entry.
 * 		
 */

#ifndef __SYS_QUEUE_LIST_H_
#define __SYS_QUEUE_LIST_H

#include <sys/queue.h>

/*
 * This function is copyright 2001 Simon Tatham.
 * 
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or
 * sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 * 
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT.  IN NO EVENT SHALL SIMON TATHAM BE LIABLE FOR
 * ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
 * CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

#define __LIST_SORT( listelm, first_elem, elem_type, field, cmp_for_sort ) do{\
	elem_type	*p; \
	elem_type	*q;\
	elem_type	*e;\
	elem_type 	*tail;\
	int			insize; \
	int 		nmerges;\
	int			psize; \
	int			qsize;\
	int			i;\
	if (first_elem == NULL){\
		(listelm)->lh_first = NULL;\
	}\
	else{\
		insize = 1;\
		while (1) {\
			p = first_elem;\
			first_elem = NULL;\
			tail = NULL;\
			nmerges = 0;\
			while (p) {\
				nmerges++;\
				q = p;\
				psize = 0;\
				for (i = 0; i < insize; i++) {\
					psize++;\
					q = q->field.le_next;\
					if (!q) break;\
				}\
				qsize = insize;\
				while (psize > 0 || (qsize > 0 && q)) {\
					if (psize == 0) {\
						e = q; q = q->field.le_next; qsize--;\
					} else if (qsize == 0 || !q) {\
						e = p; p = p->field.le_next; psize--;\
					} else if (cmp_for_sort( p, q ) <= 0) {\
						e = p; p = p->field.le_next; psize--;\
					} else {\
						e = q; q = q->field.le_next; qsize--;\
					}\
					if (tail) {\
						tail->field.le_next = e;\
					} else {\
						first_elem = e;\
					}\
					e->field.le_prev = &tail->field.le_next;\
					tail = e;\
				}\
				p = q;\
			}\
			tail->field.le_next = NULL;\
			if (nmerges <= 1){\
				(listelm)->lh_first = first_elem;\
				break;\
			}\
			insize *= 2;\
		}\
	}\
} while(0)
#define LIST_SORT( listelm, entry_type, field, data_name )	{\
	__LIST_SORT( listelm, (listelm)->lh_first, entry_type, field, data_name );\
	(listelm)->lh_first->field.le_prev = &(listelm)->lh_first;\
}

#define LIST_DEL( listelm, elem, field ){\
	if( (listelm)->lh_first == elem )\
		(listelm)->lh_first = (listelm)->lh_first->field.le_next;\
	LIST_REMOVE( elem, field );\
	free( elem );\
}

#define LIST_CLEAR( listelm, entry_type, field ){\
	entry_type *arrow;\
	entry_type *next;\
	if( !LIST_EMPTY(listelm) ){\
		arrow = (listelm)->lh_first;\
		while( arrow ){\
			next = arrow->field.le_next;\
			LIST_DEL( listelm, arrow, field );\
			arrow = next;\
		}\
	}\
}

#define LIST_EXISTS( listelm, entry_type, field, data_name, search_for, result_entry ){\
	entry_type *arrow;\
	result_entry = NULL;\
	if( ! LIST_EMPTY( listelm ) ){\
		LIST_FOREACH( arrow, listelm, field ){\
			if( arrow->data_name == search_for )\
				result_entry = arrow;\
		}\
	}\
}

#define LIST_PRINT( listelm, entry_type, field, print_func ){\
	entry_type *arrow;\
	if( LIST_EMPTY(listelm) ){\
		printf(" - List is empty - \n");\
	}\
	else{\
		LIST_FOREACH( arrow, listelm, list ){\
			if( arrow->field.le_next == NULL ){\
				printf( "[" );\
				print_func( arrow );\
				printf( "]");\
			}\
			else{\
				printf( "[" );\
				print_func( arrow );\
				printf( "]<->");\
			}\
		}\
	}\
	printf("\n");\
}

#endif /* __SYS_QUEUE_LIST_H_ */
