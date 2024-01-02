
const isMongoID = (id) => {
    return id.match(/^[0-9a-fA-F]{24}$/); // this regex pattern will check if the input id is a actual mongod ID
}


module.exports = {
    isMongoID,
}