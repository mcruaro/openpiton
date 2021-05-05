
// Author: Marcelo Ruaro <marcelo.ruaro@univ-ubs.fr>, UBS Lorient
// Date: 05.05.2021
// Description: Simple dataflow application implementing fork and join
//
#include <stdint.h>
#include <stdio.h>
#include "util.h"
#include "semaphore.h"
#include "barrier.h"

#define N 5

m_barrier barrier_it;
semaphore mutex;
semaphore empty;
semaphore full;
int buffer[N];

int rand = 0;

int produce_item(){
    return (rand++);
}

void insert_item(int item, int index){
    printf("Prod inserting %d\n", item);
    buffer[index] = item;
}

void consume_item(int index){
    int item;
    item = buffer[index];
    printf("Cons removing %d\n", buffer[index]);
    buffer[index] = -1;
}   

void producer(){
    int item;
    while(1){
        item = produce_item();
        down(&empty);
        down(&mutex);
        insert_item(item, full.count);
        up(&mutex);
        up(&full);
    }

}

void consumer(){
    //barrier_wait(&barrier_it, 2);

    int item;
    while(1){
        item = produce_item();
        down(&full);
        down(&mutex);
        consume_item(full.count+1);
        up(&mutex);
        up(&full);
    }
    
}

int main(int argc, char** argv) {

    uint32_t core_id, core_num;
    core_id = argv[0][0];
    core_num = argv[0][1];

    sema_init(&mutex, 1);
    sema_init(&empty, N);
    sema_init(&full, 0);
    barrier_init(&barrier_it, 2);

    for (int i = 0; i < N; i++) {
        buffer[i] = -1;
    }
    

    switch(core_id){
        case 0:
            producer();
            break;
        case 1:
            consumer();
            break;
        default:
            printf("ERROR, unknown core_id = %d\n", core_id);
    }


    //volatile static uint32_t amo_lrsc[20];

    
    return 0;

}
