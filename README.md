# Asynchronous_FIFO Design 

The design is as follows:
async_fifo.v - This is the top level wrapper of the design. 
fifomemory.v - This is fifo memory module.
rdomain.v - This module is the read domain, that generates rptr and rempty. 
Wdomain.v - This module is the write domain, that generates wptr and wfull. 
sync_rptr.v and sync_wptr.v - These are the 2 flop synchronizer modules, that syncs wptr and rptr across read and write clock domains. 

Design reference - http://www.sunburst-design.com/papers/CummingsSNUG2002SJ_FIFO1.pdf
