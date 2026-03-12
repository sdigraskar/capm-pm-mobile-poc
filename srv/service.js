module.exports = (srv) => {

  const { User } = srv.entities; 
     
    srv.on("LoginOp", async (req) => {

    const { USERNAME, PASSWORD } = req.data;

    const user = await cds.run(SELECT.from(User)
        .where({USERNAME: USERNAME, PASSWORD: PASSWORD})
      );

    if (!user.length) {
        return "Invalid User";
    }

    return "Login Success";
  });



}