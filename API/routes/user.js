const express = require('express');
const isAuthorized = require("../helper/authtoken")
const auth = require("../controller/user/auth.js")
const rent = require("../controller/user/rent.js")
const sub = require("../controller/admin/sub.js")
const place = require("../controller/user/place.js")
const router = express.Router()


router.post('/login', async (req, res) => {
    await auth.login(req.body, res)
})



router.post('/signUp', async (req, res) => {
    await auth.signUp(req.body, res)
})



router.post('/logout', isAuthorized, async (req, res) => {
    await auth.logout(req, res)
})

router.get('/getProfile', isAuthorized, async(req, res) => {
    await auth.getProfile(req,res)
})

router.put('/updateProfile', isAuthorized, async(req, res) => {
    await auth.updateProfile(req, res)
})

router.get('/getPlaceUser', isAuthorized, async(req,res) => {
    await place.getPlaceUser(res)
})
//rent

router.post('/createRent', isAuthorized, async(req,res) => {
    await rent.createRent(req.body,res)
})

router.post('/getRentByIdUSer', isAuthorized, async(req, res) => {
    await rent.getRentByIdUser(req.body, res)
})

router.delete('/cancelRent', isAuthorized, async(req, res) => {
    await rent.cancelRent(req.body, res)
})

//sub

router.post('/subforuser', isAuthorized, async(req,res) => {
    await sub.SubForUser(req.body, res)
})

router.post('/getSubUser', isAuthorized, async(req,res) => {
    await sub.getSubUser(req.body, res)
})
// Define the User schema in the swagger, we will use it in endpoints descriptions

/**
 * @swagger
 * components:
 *   schemas:
 *     User:
 *       type: object
 *       required:
 *         - firstname
 *         - lastname
 *         - phonenumber
 *         - pseudo
 *         - email
 *         - password
 *       properties:
 *         id:
 *           type: string
 *           description: The auto-generated id of the book
 *         firstname:
 *           type: string
 *           description: The user firstname
 *         lastname:
 *           type: string
 *           description: The user lastname
 *         phonenumber:
 *           type: string
 *           description: The user phone number
 *         pseudo:
 *           type: string
 *           description: The user pseudo
 *         email:
 *           type: string
 *           description: The user email
 *         password:
 *           type: string
 *           description: The user password
 *         token:
 *           type: string
 *           description: The user token for authentication
 *         fk_role:
 *           type: string
 *           description: The user role
 *       example:
 *         id: 2e79c624d47102bb0cc16
 *         firstname: Tagri
 *         lastname: Hokuto
 *         phonenumber: 0601020304
 *         pseudo: Yone_btc
 *         email: yone4life@gmail.com
 *         password: YoneBtcEth
 */

/**
 * @swagger
 * components:
 *   schemas:
 *     UserLogin:
 *       type: object
 *       required:
 *         - email
 *         - password
 *       properties:
 *         email:
 *           type: string
 *           description: The user email
 *         password:
 *           type: string
 *           description: The user password
 *       example:
 *         email: gkata@gmail.com
 *         password: "123456"
 */

/**
 * @swagger
 * components:
 *   schemas:
 *     UserToken:
 *       type: object
 *       properties:
 *         token:
 *           type: string
 *           description: The user token
 *       example:
 *         token: JhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNjJlYmJlZGZhMmRi...
 */

 /**
  * @swagger
  * tags:
  *   name: User
  *   description: User management
  */

 /**
 * @swagger
 * components:
 *   securitySchemes:
 *    bearerAuth:
 *     type: http
 *     scheme: bearer
 *     bearerFormat: JWT
 */

/**
 * @swagger
 * /login:
 *   post:
 *     summary: Login a user
 *     tags: [User]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/UserLogin'
 *     responses:
 *       200:
 *         description: The user was successfully login
 *         content:
 *           application/json:
 *             schema:
 *                 $ref: '#/components/schemas/UserToken'
 *       500:
 *         description: Internal server error
 */

/**
 * @swagger
 * /signUp:
 *   post:
 *     summary: Create a new user
 *     tags: [User]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/User'
 *     responses:
 *       200:
 *         description: The user was successfully created
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/User'
 *       500:
 *         description: Internal server error
 */

/**
 * @swagger
 * /logout:
 *   post:
 *     summary: Logout a user
 *     tags: [User]
 *     security:
 *      - bearerAuth: []
 *     responses:
 *       200:
 *         description: The user was successfully disconnected
 *         content:
 *           text/html:
 *             schema:
 *              type: string
 *             required: true
 *             description: confirm logout
 *             example: "you are disconnected"
 *       500:
 *         description: Internal server error
 */

module.exports = router