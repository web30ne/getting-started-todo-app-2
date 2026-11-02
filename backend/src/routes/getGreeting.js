const GREETING = 'this first vm is in this container!';

module.exports = async (req, res) => {
    res.send({
        greeting: GREETING,
    });
};
