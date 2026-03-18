const cds = require('@sap/cds');
// const { SELECT } = cds;

module.exports = (srv) => {

  const { User, UserPlants } = srv.entities;

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

    // const { UserPlants } = srv.entities;

    // USER PLANT
    const plants = await db.run(
      SELECT.one.from(UserPlants).where({ UID: userUID })

    );
    console.log(plants);
    const userPlant = plants.length ? plants[0].PLANT : null;

    let equipment = [], location = [], workspace = [], navclass = [],
        printer = [], articles = [], group = [];

    const {UserEquipment} = srv.entities;    

    if (userPlant) {

      equipment = await db.run(
        SELECT.from(UserEquipment)
        .where({ UID: userUID, PLANT: userPlant })
      );

      location = await db.run(
        SELECT.from('assets.USER_FUNCTIONAL_LOCATION')
        .where({ UID: userUID, PLANT: userPlant })
      );

      workspace = await db.run(
        SELECT.from('assets.USER_WORKCENTER')
        .where({ UID: userUID, PLANT: userPlant })
      );

      navclass = await db.run(
        SELECT.from('assets.USER_CLASS')
        .where({ UID: userUID, PLANT: userPlant })
      );

      printer = await db.run(
        SELECT.from('assets.USER_PRINTER')
        .where({ UID: userUID, PLANT: userPlant })
      );

      articles = await db.run(
        SELECT.from('assets.USER_ARTICLE')
        .where({ UID: userUID, PLANT: userPlant })
      );

      group = await db.run(
        SELECT.from('assets.USER_GROUPS')
        .where({ UID: userUID, PLANT: userPlant })
      );
    }

    return {
      login: true,
      userID: userUID,
      name: user.FIRSTNAME + " " + user.LASTNAME,
      user: user.USERNAME,
      email: user.MAIL,
      phone: user.TELEPHONE,
      language: user.LANGUAGE,
      firstname: user.FIRSTNAME,
      lastname: user.LASTNAME,
      jobfunction: user.JOB_FUNCTION,
      groupfunction: user.GROUP_FUNCTION,
      plant: userPlant,
      article: user.ARTICLE,
      workshift: user.WORK_SHIFT,
      equipment,
      location,
      workspace,
      navclass,
      printer,
      articles,
      group,
      logDate: user.LOG_DATE
    };

  });

};