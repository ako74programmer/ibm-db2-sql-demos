--  category:  IBM i Services
--  description:  Application - Data Queue Entries
--

--
-- Data queue example
--
create schema TheQueen;
cl:CRTDTAQ DTAQ(TheQueen/OrderDQ) MAXLEN(100) SEQ(*KEYED) KEYLEN(3);
call qsys2.send_data_queue(message_data       => 'Sue - Dilly Bar',
                           data_queue         => 'ORDERDQ', 
                           data_queue_library => 'THEQUEEN',
                           key_data           => '010');
call qsys2.send_data_queue(message_data       => 'Sarah - Ice cream cake!',
                           data_queue         => 'ORDERDQ', 
                           data_queue_library => 'THEQUEEN',
                           key_data           => '020');
call qsys2.send_data_queue(message_data       => 'Scott - Strawberry Sundae',
                           data_queue         => 'ORDERDQ', 
                           data_queue_library => 'THEQUEEN',
                           key_data           => '030');
call qsys2.send_data_queue(message_data       => 'Scott - Pineapple Shake',
                           data_queue         => 'ORDERDQ', 
                           data_queue_library => 'THEQUEEN',
                           key_data           => '030');
stop;

-- Search what's on the DQ
select message_data, key_data from table
     (qsys2.data_queue_entries('ORDERDQ', 'THEQUEEN', 
                               selection_type => 'KEY',
                               key_data       => '030',
                               key_order      => 'EQ'));
stop;

-- Order fulfilled!
select message_data, message_data_utf8, message_data_binary, key_data, sender_job_name, sender_current_user
  from table (
      qsys2.receive_data_queue(
        data_queue => 'ORDERDQ', data_queue_library => 'THEQUEEN', 
        remove => 'YES',
        wait_time => 0, 
        key_data => '030', 
        key_order => 'EQ')
    );
stop;

-- What remains on the queue?
select * from table
     (qsys2.data_queue_entries('ORDERDQ', 'THEQUEEN', 
                               selection_type => 'KEY',
                               key_data       => '030',
                               key_order      => 'LE'));
