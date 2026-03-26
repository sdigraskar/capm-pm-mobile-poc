const cds = require('@sap/cds');
// const { SELECT } = cds;

module.exports = (srv) => {

  const { User} = srv.entities;

  srv.on('LoginOp', async (req) => {

    debugger; // ✅ will trigger on POST

    const { USERNAME, PASSWORD } = req.data;

    // const username = USERNAME?.toUpperCase();

    const db = await cds.connect.to('db');   

    // USER LOGIN
    const user = await db.run(
      SELECT.one.from(User).where({        
        USERNAME: USERNAME,
        PASSWORD: PASSWORD, })
    
    );

    if (!user) {
      return { login: false };
    }

    const userUID = user.UID;

    const { UserPlants } = srv.entities;

    // USER PLANT
    const plant  = await db.run(
      SELECT.one.from(UserPlants).where({ UID: userUID })

    );

    const userPlant = plant?.PLANT || null;
    const userPlantname = plant?.PLANT_NAME || null; 
      

    let location = [], locationname = [];
    let workspace = [], workspacename = [];
    let equipment = [], equipmentname = [];
    let navclass = [], navclassname = [];
    let printer = [], printername = [];
    let articles = [], articlesname = [];
    let plants = [], plantsname = [];
    let group = [], groupname = [];

    let workspacegroup = "";
    let plantDetail = {};


    const {UserEquipment,UserFunctionalLocation,
            UserWorkcenter,UserClass,UserPrinter,
          UserArticle,UserGroups,PlantsManagement,PicklistWorkcenter} = srv.entities;    

    if (plant) {      

      const resultEquipment = await db.run(
        SELECT.from(UserEquipment)
        .where({ UID: userUID, PLANT: userPlant })
      );

      const resultLocation = await db.run(
        SELECT.from(UserFunctionalLocation)
        .where({ UID: userUID, PLANT: userPlant })
      );

      const resultWorkcenter = await db.run(
        SELECT.from(UserWorkcenter)
        .where({ UID: userUID, PLANT: userPlant })
      );

       
      const resultClass = await db.run(
        SELECT.from(UserClass)
        .where({ UID: userUID, PLANT: userPlant })
      );

      const resultPrinter = await db.run(
        SELECT.from(UserPrinter)
        .where({ UID: userUID, PLANT: userPlant })
      );

      const resultArticle = await db.run(
        SELECT.from(UserArticle)
        .where({ UID: userUID, PLANT: userPlant })
      );

      const resultGroup = await db.run(
        SELECT.from(UserGroups)
        .where({ UID: userUID, PLANT: userPlant })
      );

      const resultPlant = await db.run(
        SELECT.from(UserPlants)
          .where({ UID: user.UID, PLANT: userPlant })
      );

       plantDetail = await db.run(
        SELECT.one.from(PlantsManagement)
          .where({ PLANT: userPlant })
      ) || {};

      // const {PicklistWorkcenter} = srv.entities;
      const WORK_CENTER = resultWorkcenter[0].WORK_CENTER;

       if (resultWorkcenter.length) {
        const picklist = await db.run(
          SELECT.one.from(PicklistWorkcenter)
            .where({
              SWERK: String(userPlant),
              ARBPL: String(WORK_CENTER)
            })
        );
        workspacegroup = picklist?.GROUP || "";
      }

      location = resultLocation.map(x => x.FLOC);
      locationname = resultLocation.map(x => x.FLOC_NAME);

      workspace = resultWorkcenter.map(x => x.WORK_CENTER);
      workspacename = resultWorkcenter.map(x => x.WORK_CENTER_NAME);

      equipment = resultEquipment.map(x => x.EQUI);
      equipmentname = resultEquipment.map(x => x.EQUI_NAME);

      navclass = resultClass.map(x => x.CLASS);
      navclassname = resultClass.map(x => x.CLASS_NAME);

      printer = resultPrinter.map(x => x.PRINTER);
      printername = resultPrinter.map(x => x.PRINTER_NAME);

      articles = resultArticle.map(x => x.ARTICLE);
      articlesname = resultArticle.map(x => x.ARTICLE_NAME);

      group = resultGroup.map(x => x.GROUPS);
      groupname = resultGroup.map(x => x.GROUPS_NAME);

      plants = resultPlant.map(x => x.PLANT);
      plantsname = resultPlant.map(x => x.PLANT_NAME);

    }

    let newuser = {
      login: true,
      userID: user.UID,
      name: `${user.FIRSTNAME} ${user.LASTNAME}`,
      user: user.USERNAME,
      email: user.MAIL,
      phone: user.TELEPHONE,
      language: user.LANGUAGE,
      firstname: user.FIRSTNAME,
      lastname: user.LASTNAME,
      jobfunction: user.JOB_FUNCTION,
      groupfunction: user.GROUP_FUNCTION,
      plant: userPlant,
      plantname: userPlantname,
      article: user.ARTICLE,
      workshift: user.WORK_SHIFT,

      location,
      locationname,
      workspace,
      workspacename,
      workspacegroup,
      equipment,
      equipmentname,
      navclass,
      navclassname,
      printer,
      printername,
      plants,
      plantsname,
      articles,
      articlesname,
      group,
      groupname,

      plantsModel: plantDetail.NOTIFICATION_MODEL || "",
      plantsReservation: plantDetail.RESERVATIONS || "",

      logDate: user.LOG_DATE,

      TPMVisible: plantDetail.TPMAPP === 'X',
      ManualDate: plantDetail.MANUALDATE === 'X',
      TPMYellowCard: plantDetail.TPMYELLOWCARD === 'X',
      BreakDown: plantDetail.BREAKDOWN === 'X',
      Preventives: plantDetail.PREVENTIVES === 'X',

      PDias: plantDetail.PDIAS || 15,
      PDiasOrder: plantDetail.PDIASORDER || 15,
      WarehouseQuantityVisible: plantDetail.WAREHOUSEQUANTITY === 'X'
    };

    // 🔹 WH Permits
    let whpermits = "";

    if (newuser.jobfunction === "TM") {
      whpermits = plantDetail.TMWHAPPS;
    } else if (newuser.jobfunction === "SM") {
      whpermits = plantDetail.SMWHAPPS;
    } else if (newuser.jobfunction === "RA") {
      whpermits = "MGSRICOR";
    }

    newuser.whpermits = whpermits;

    return newuser;

  });

};