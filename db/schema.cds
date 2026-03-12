namespace asset;

context master {


    entity User {

        key UID            : Integer;

            USERNAME       : String(50);
            FIRSTNAME      : String(50);
            LASTNAME       : String(100);
            PASSWORD       : String(50);
            JOB_FUNCTION   : String(20);
            MAIL           : String(100);
            TELEPHONE      : String(50);
            LANGUAGE       : String(10);

            GROUPS         : String(50);
            ARTICLE        : String(50);
            PLANT          : String(10);
            WORK_SHIFT     : String(10);
            GROUP_FUNCTION : String(50);

            LOG_DATE       : Timestamp;

    }

   

}
