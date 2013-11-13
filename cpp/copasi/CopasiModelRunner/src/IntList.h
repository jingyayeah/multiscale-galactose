/*
 * IntList.h
 *
 *  Created on: Nov 13, 2013
 *      Author: mkoenig
 */

#ifndef INTLIST_H_
#define INTLIST_H_

#include <iostream>

class IntList {
  public:
    IntList();                         // constructor; initialize the list to be empty
    void AddToEnd(int k);              // add k to the end of the list

  private:
    static const int SIZE = 10;      // initial size of the array
    int *Items;                      // Items will point to the dynamically allocated array
    int numItems;                    // number of items currently in the list
    int arraySize;                   // the current size of the array
};

#endif /* INTLIST_H_ */
