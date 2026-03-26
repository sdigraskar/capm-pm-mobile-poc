namespace asset;

context master {

    entity FAVORITE_SEARCH {
        key UID        : String(8);
        key SEARCHNAME : String(100);
        key FILTERNAME : String(100);
        key PROPERTY   : String(100);
            VALUE      : String(100);
    }

    entity INVENTORY {
        key IBLNR          : String(10);
        key GJAHR          : String(4);
            WERKS          : String(4);
            LGORT          : String(4);
            STATUS         : String(30);
            CREA_DATE      : Timestamp;
            CREA_USER      : String(100);
            CREA_USER_TEXT : String(100);
            MOD_USER       : String(100);
            MOD_USER_TEXT  : String(100);
    }

    entity INVENTORY_POSITION {
        key IBLNR : String(10);
        key ZEILE : String(10);
            MATNR : String(18);
            MENGE : String;
            MEINS : String(3);
            ERFMG : String;
            ERFME : String(9);
            XNULL : String(1);
            COUNT : String(1);
    }

    entity ORDER_NOTIFICATION {
        key AUFNR          : String(100);
        key VORNR          : String(100);
        key ARBID          : String(100);
            ARBID_DESC     : String(100);
            START_DATE     : Timestamp;
            END_DATE       : Timestamp;
            WORK_SHIFT     : String(100);
            NOTIF_TEXT     : String(40);
            NOTIF_END      : String(1);
            OP_DESCRIPTION : String(150);
    }

    entity PICKLIST_EQUIPEMENT {
        key SWERK       : String(4);
        key EQUNR       : String(18);
        key LANGU       : String(2);
            SHTXT       : String(40);
            TPLNR       : String(40);
            INGRP       : String(40);
            TIDNR       : String(40);
            TIDNRSELECT : String(40);
    }

    entity PICKLIST_LOCATION {
        key SWERK : String(4);
        key TPLNR : String(40);
        key LANGU : String(2);
            INGRP : String(40);
            PLTXT : String(40);
    }

    entity PICKLIST_MATERIAL {
        key SWERK         : String(4);
        key LGORT         : String(4);
        key MATNR         : String(18);
        key LANGU         : String(2);
            MAKTX         : String(40);
            LGPBE         : String(18);
            MATKL         : String(9);
            LABST         : String;
            MEINS         : String(3);
            SALK3         : String;
            WAERS         : String(5);
            KZKRI         : String(1);
            DISMM         : String(2);
            MINBE         : String;
            DISLS         : String(2);
            BSTMI         : String;
            BSTMA         : String;
            BSTFE         : String;
            MABST         : String;
            ZMANUFACTURER : String(40);
            ZMANUF_REF    : String(40);
    }

    entity PICKLIST_WORKCENTER {
        key SWERK : String(4);
        key ARBPL : String(8);
            KTEXT : String(40);
            GROUP : String(2);
    }

    entity PICKLISTS {
        key SWERK              : String(4);
        key PICKLIST_ID        : String;
        key LANGU              : String(2);
        key EXT_CODE           : String(40);
            PICKLIST_TYPE      : String(4);
            PICKLIST_NAME      : String(40);
            INT_CODE           : String(40);
            DESCRIPTION        : String(60);
            ID_PICKLIST_PARENT : String(4);
            PARENT_CODE        : String(255);
            CUSTOMER_FIELD     : String(100);
            OPTION_ACTIVE      : String(1);
    }

    entity PLANTS_MANAGEMENT {
        key PLANT              : String(100);
            PLANT_NAME         : String(100);
            NOTIFICATION_MODEL : String(100);
            RESERVATIONS       : String(100);
            SMWHAPPS           : String(100);
            TMWHAPPS           : String(100);
            MANUALDATE         : String(1);
            TPMYELLOWCARD      : String(1);
            TPMAPP             : String(1);
            PDIAS              : Integer;
            PDIASORDER         : Integer;
            WAREHOUSEQUANTITY  : String(1);
    }

    entity USER {
        key UID            : String;
            USERNAME       : String(100);
            FIRSTNAME      : String(100);
            LASTNAME       : String(100);
            PASSWORD       : String(100);
            JOB_FUNCTION   : String(100);
            GROUP_FUNCTION : String(100);
            MAIL           : String(100);
            TELEPHONE      : String(100);
            LANGUAGE       : String(100);
            GROUPS         : String(100);
            ARTICLE        : String(100);
            PLANT          : String(100);
            WORK_SHIFT     : String(100);
            LOG_DATE       : Timestamp;
    }


    entity USER_ARTICLE {
        key UID          : String(8);
        key PLANT        : String(100);
        key ARTICLE      : String(100);
            ARTICLE_NAME : String(100);
    }

    entity USER_CLASS {
        key UID        : String(8);
        key PLANT      : String(100);
        key CLASS      : String(100);
            CLASS_NAME : String(100);
    }

    entity USER_EQUIPMENT {
        key UID       : String(8);
        key PLANT     : String(100);
        key EQUI      : String(100);
            EQUI_NAME : String(100);
    }

    entity USER_FUNCTIONAL_LOCATION {
        key UID       : String(8);
        key PLANT     : String(100);
        key FLOC      : String(100);
            FLOC_NAME : String(100);
    }

    entity USER_GROUP {
        key UID        : String(8);
        key PLANT      : String(100);
        key GROUP      : String(100);
            GROUP_NAME : String(100);
    }

    entity USER_GROUPS {
        key UID         : String(8);
        key PLANT       : String(100);
        key GROUPS      : String(100);
            GROUPS_NAME : String(100);
    }

    entity USER_PLANTS {
        key UID        : String(8);
        key PLANT      : String(100);
            PLANT_NAME : String(100);
    }

    entity USER_PRINTER {
        key UID          : String(8);
        key PLANT        : String(100);
        key PRINTER      : String(100);
            PRINTER_NAME : String(100);
    }

    entity USER_WORKCENTER {
        key UID              : String(8);
        key PLANT            : String(100);
        key WORK_CENTER      : String(100);
            WORK_CENTER_NAME : String(100);
    }

    entity Location {
        key SWERK : String(4); // Plant
        key TPLNR : String(40); // Functional Location
        key LANGU : String(2); // Language

            PLTXT : String(40); // Description
            INGRP : String(40); // Planner Group
    }

    entity Equipement {
        key SWERK       : String(4); // Plant
        key EQUNR       : String(18); // Equipment Number
        key LANGU       : String(2); // Language

            SHTXT       : String(40); // Description
            TPLNR       : String(40); // Functional Location

            TIDNR       : String(40);
            TIDNRSELECT : String(40);
            INGRP       : String(40);

            // 🔗 Association to Location
            location    : Association to Location
                              on  location.SWERK = SWERK
                              and location.TPLNR = TPLNR
                              and location.LANGU = LANGU;
    }

    entity Material {
        key SWERK         : String(4); // Plant
        key LGORT         : String(4); // Storage Location
        key MATNR         : String(18); // Material Number
        key LANGU         : String(2); // Language

            MAKTX         : String(40); // Description
            LGPBE         : String(18); // Storage Bin
            MATKL         : String(9); // Material Group

            LABST         : Decimal(15, 3); // Stock
            MEINS         : String(3); // Unit

            SALK3         : Decimal(15, 3); // Value
            WAERS         : String(5); // Currency

            KZKRI         : String(1);
            DISMM         : String(2);

            MINBE         : Decimal(15, 3);
            DISLS         : String(2);

            BSTMI         : Decimal(16, 3);
            BSTMA         : Decimal(16, 3);
            BSTFE         : Decimal(16, 3);
            MABST         : Decimal(16, 3);

            ZMANUFACTURER : String(40);
            ZMANUF_REF    : String(40);
    }

    entity Workcenter {
        key SWERK : String(4); // Plant
        key ARBPL : String(8); // Work Center

            KTEXT : String(40); // Description
            GROUP : String(20); //
    }

    entity Plants {
        key PLANT              : String(100); // Plant ID

            PLANT_NAME         : String(100);
            NOTIFICATION_MODEL : String(100);
            RESERVATIONS       : String(100);

            SMWHAPPS           : String(100);
            TMWHAPPS           : String(100);

            TPMAPP             : String(1);

            PDIAS              : Integer; // Edm.Int32 → Integer
            PDIASORDER         : Integer;

            WAREHOUSEQUANTITY  : String(1);
            OFFLINE            : String(1);
            MANUALDATE         : String(1);
            TPMYELLOWCARD      : String(1);
            BREAKDOWN          : String(1);
            PREVENTIVES        : String(1);
    }

}
