const express = require("express");
const cors = require("cors");
const bodyParser = require("body-parser");

const app = express();
app.use(cors());
app.use(bodyParser.json());

// Temporary in-memory storage
const users = [{ email: "admin@example.com", password: "Admin@123" },{ email: "aaryan3783@gmail.com", password: "12345678" }];

// **GET API** - Fetch all users
app.get("/users", (req, res) => {
    res.status(200).json(users);
});

// **POST API** - Register a new user
app.post("/register", (req, res) => {
    const { email, password } = req.body;

    if (!email || !password) {
        return res.status(400).json({ message: "Email and password are required" });
    }

    const existingUser = users.find(user => user.email === email);
    if (existingUser) {
        return res.status(400).json({ message: "User already exists" });
    }

    users.push({ email, password });
    res.status(201).json({ message: "User registered successfully" });
});

// **POST API** - User login
app.post("/login", (req, res) => {
    const { email, password } = req.body;

    const user = users.find(user => user.email === email && user.password === password);
    if (!user) {
        return res.status(401).json({ message: "Invalid email or password" });
    }

    res.status(200).json({ message: "User verified", status: "success" });
});

// **GET API** - for show data in dashboard
    const dashboardata = [{"TotalUsers": 21}
    ,{"ActiveUsers": 100}
    ,{"SubscribedUsers": 10}
    ,{"TotalEarning":2494}
      ];
    app.get("/dashboard", (req, res) => {
    res.status(200).json(dashboardata);
});

// Get api for show Video data
const videos = [
    {
        "id": 1,
        "name": "Inception",
        "language": "English",
        "genre": "Sci-Fi",
        "category": "Movie",
        "duration": "2h 28m",
        "thumbnail": "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.pexels.com%2Fsearch%2Fbeautiful%2F&psig=AOvVaw2JijKbhXyC_LXJUeTYT6fw&ust=1741772694423000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCLCrqIjfgYwDFQAAAAAdAAAAABAI",
        "videoUrl": "https://youtu.be/Nt-AsZh5woE?si=--QD9VtIW1eUG-WQ"
    },
    {   "id": 2,
        "name": "Aspirants",
        "language": "Hindi",
        "genre": "Sci-Fi",
        "category": "webseries",
        "duration": "6h 28m",
        "thumbnail": "https://www.google.com/search?sa=X&sca_esv=0cea375fb25910d8&rlz=1C1CHBF_en-GBIN1110IN1110&biw=1280&bih=551&sxsrf=AHTn8zoPuN6avaIjC5vFpaM3BZfFXYX2tQ:1741686608394&q=Aspirants&stick=H4sIAAAAAAAAAF2Vu4_bNhzHTxf4etG1aOAgaHFdDgfUKAjkJOpl2YARpFOWTJfOgiRK1Mt6kdbDU5fsQedOGYsM_RMKdGrWAhkzdGv_gg5FUftM8sxu_pgP8fH7fng-uf5MwxqE7aJfBM7aNJ4kaYnSqz4KrkjUphG5KlJC3yuHbhlGwUiMjHPuNJCMjvleudDWmg7hYG6LLW-Ns9Fq5oHHGVvh6JlGLWZr0RYXjiW4t53cjnPOCSTbnCYxn92M50NsilbUodZaiNGJ08GhcER7lo_zIOuh4GAeBEG25lzUZUIb2HBu3RAROIjV8SMR47edrpttz3ncrcCj9Zxz04Yd9uxB9Dd1t0BQtGOvLZJscDgjLwgNfRGKsywXVombToyHNWx6U3wf96adYCja421su1Yi7iLrjDUKe7GfLEYDyQfMObRN4uixOI-msbBdjGJ9XUONmtbi9ih0F70x1kcc2Ikj9p-M1InHxShYNxZwWwiOm8Zsa1fcPsU6dAss7gvrpKBuK-bvxtYZukH0zxvTQ0Nu3_cvkO66CWeyjj2YZ7rYr-WFuwMU84d619LQCUR_B6Jt4N5Xl4Oc-YDR8f50NBf1kaOi3tUbEfXQb_ugtlpx_05jGhYc_1BWF4_-_Pvj40vrh3e_fVBu1C_ycKmtI5T6yz7xqUcrr_dpmEwfq5OX-7-n6vRcPXtZdbt8ffr2wbtzdfJiH7vpv4r68DbcBBF61a2nHxX1gd_i6Qdl-ruifvKqu02qnlz-qqi_KOrZIZ5PTk6-f_blKTiNyuVPSkJpTZaalpY0KunTwg9uwqqtb3BV4SLa_V5rzeZu3LO-anNS-2G0ehH5aEZ9vNotYRPStCpnGxJ5VYE8EvltmKxou4lmhV_iVVQ-_e52lqLVoeVr83lox66tO87chboDDWO2_-CGrLRDj1mcFjRqI-TJ_y9Pv1GuH_31-sd_LnaHsY-3mdv65ef_E8-1aALyrQK5qIGcKSALCMgVCeQAAbm-gFyeHJm7OLIwc2TZBHIUODKPAbnwBB68xZFpjSNLGZClwJE5BsgR4MiMx5EJgSNzOUemS47MzRyZXDgyU3NkagTyq8CRBYkj8xxHFnMgWxnIkuLIHAtkZXNkxubIAgvk_HNk-gCy7e7xTgZHuHcfR6YyIJuTIxMZkN8Jjkwb4PjFBMcPnH7y7VdaWBVFdBdGLdms_dLbx2_j44i8nTx8Tuq09UtKfp6cvjlT_gO4_pXKxgcAAA&ved=2ahUKEwjHyOmc4IGMAxW11DgGHeDKCSMQ-BZ6BAhAEFA",
        "videoUrl": "https://youtu.be/0Kl1ucZuSZ8?si=oQTkEovhNYueqX8C"
    },
    
   {        "id": 3,
            "name": "PANCHYAT",
            "language": "Hindi",
            "genre": "Sci-Fi",
            "category": "webseries",
            "duration": "6h 28m",
            "thumbnail": "https://www.google.com/search?sa=X&sca_esv=0cea375fb25910d8&rlz=1C1CHBF_en-GBIN1110IN1110&biw=1280&bih=551&sxsrf=AHTn8zp3RWIMwnsxMqG-n6NG52ikJ4uryQ:1741686922888&q=Panchayat+(TV+series)&stick=H4sIAAAAAAAAAO2VvY_kNBiHGVaze5tZ4OTTARoKVishgYVu4nxNstIJCYSA4gTiVlBa-c7MJJnEyeZjeiokBAhRXbU1BSUF_wCno6WkQFDAX0BBweyO_Wbc03HlY1v2a-d9frk1PntuFs8IWUZBV626WHuhDb0qZIuwOk0WebB4PNotWFklqXpLF7yMA6-vtCVwa1orM1rB-twx8rhsBCd040dG5AmODb-nulYIjpa9Uc49CvvxggSnRZ7UJSlhftOoqs5a2I-yNFl21uPRZJbNVKJH8y6CahOrIV06VJ8ETcAMxxCrSadv0o2YZU7reFYGq5ntBxXpoNaS-U1MzU5w7Tcaow3UGlDP11THh7uVpc4Kmw7VBNa8iwPB_bYeWhdzuBspSNnqw1uzYBOnlgG86ufesiVw91Y3k5jAWzdlrRV1AffxTb2y1AjWZ7GfdHoD59exSuw0hv37uW2Q0rQFV1lEyWqpwnlRMPeqdvjWpU6DbmXC-T2zuqaD-9bE9szEaof3op6lG7DfUlftNCDD_TeRalcU3jfKCpqnegX7t4Hpq3oE85vItI0EejHpayvqnR7O0yPNyRm8z7ZXnYjWUE-iag7ZpLC-SYI8KywNeo-USz_2oF7WblqvMNhvo_uT23_-_eudqfH1dz_9MrqnvLTyz2dZGCzc8zZxa1qvaevWfoLuKOMH18NIQbeUwwfrZivYydXB70fK-P1rzdCPI-X4oX_phcFFk6FHI-XAZTH6ZoS-2k58kNchq0K_Ru8oRx8WIXPzANnIUsbvsfVlge4Oo3v7oxeH4Qk6Vo4umofJuq3QW8O4gTTl-OMwdevtwWv0mnL4bl4v6h49Pz1RlGs3tDJr2mg6OT-GZDi7_ddnj_6ZbI-6XqCvTHW6NwmDWO4-LMuBZe-x_KkFcnOw_KGxnCECeQRguUsFckmw_M0FciUBd3khkIeXQJ4eWG43LNuL5eYWyHNNII9RgdxsgVx8DH17k7FYbmOB3BrAXUBiOb8F8ngWyA3GcsML5NmL5fjAchpiOSwF8iwVyNXBcrJgOSgEcm8F8tgA3KWuQB5iWHZYII9EgTxBBPLAwnIeC-RxiPf_FXj_N6M-8_YrM3-dpltFF-t8llxmbk5TN48v3Tisrg7-OFKUT0PvdKcI-kGS_Vsu-xcj9Pl_L7szjN9Db-7L_irIfjJVlMHlo_Pxza__DN1ofoL2c4BP7Q091fyp5v8bzV_e1_zmR0_jMGdhFf785Mn9q_Hdj9zcT9zerU9fv_iE-_7G9-Nnvzwc_QvW7H8ebQsAAA&stq=1&cs=0&lei=pAjQZ8iHHeio4-EPg5i9oQs#",
            "videoUrl": "https://youtu.be/T0vBY9SNAWU?si=qWrfEQDzS645wgDG"
    },
    {   "id": 4,
        "name": "The Family",
        "language": "Hindi",
        "genre": "Sci-Fi",
        "category": "webseries",
        "duration": "10h 28m",
        "thumbnail": "https://www.google.com/search?sa=X&sca_esv=0cea375fb25910d8&rlz=1C1CHBF_en-GBIN1110IN1110&biw=1280&bih=551&sxsrf=AHTn8zp3RWIMwnsxMqG-n6NG52ikJ4uryQ:1741686922888&q=Panchayat+(TV+series)&stick=H4sIAAAAAAAAAO2VvY_kNBiHGVaze5tZ4OTTARoKVishgYVu4nxNstIJCYSA4gTiVlBa-c7MJJnEyeZjeiokBAhRXbU1BSUF_wCno6WkQFDAX0BBweyO_Wbc03HlY1v2a-d9frk1PntuFs8IWUZBV626WHuhDb0qZIuwOk0WebB4PNotWFklqXpLF7yMA6-vtCVwa1orM1rB-twx8rhsBCd040dG5AmODb-nulYIjpa9Uc49CvvxggSnRZ7UJSlhftOoqs5a2I-yNFl21uPRZJbNVKJH8y6CahOrIV06VJ8ETcAMxxCrSadv0o2YZU7reFYGq5ntBxXpoNaS-U1MzU5w7Tcaow3UGlDP11THh7uVpc4Kmw7VBNa8iwPB_bYeWhdzuBspSNnqw1uzYBOnlgG86ufesiVw91Y3k5jAWzdlrRV1AffxTb2y1AjWZ7GfdHoD59exSuw0hv37uW2Q0rQFV1lEyWqpwnlRMPeqdvjWpU6DbmXC-T2zuqaD-9bE9szEaof3op6lG7DfUlftNCDD_TeRalcU3jfKCpqnegX7t4Hpq3oE85vItI0EejHpayvqnR7O0yPNyRm8z7ZXnYjWUE-iag7ZpLC-SYI8KywNeo-USz_2oF7WblqvMNhvo_uT23_-_eudqfH1dz_9MrqnvLTyz2dZGCzc8zZxa1qvaevWfoLuKOMH18NIQbeUwwfrZivYydXB70fK-P1rzdCPI-X4oX_phcFFk6FHI-XAZTH6ZoS-2k58kNchq0K_Ru8oRx8WIXPzANnIUsbvsfVlge4Oo3v7oxeH4Qk6Vo4umofJuq3QW8O4gTTl-OMwdevtwWv0mnL4bl4v6h49Pz1RlGs3tDJr2mg6OT-GZDi7_ddnj_6ZbI-6XqCvTHW6NwmDWO4-LMuBZe-x_KkFcnOw_KGxnCECeQRguUsFckmw_M0FciUBd3khkIeXQJ4eWG43LNuL5eYWyHNNII9RgdxsgVx8DH17k7FYbmOB3BrAXUBiOb8F8ngWyA3GcsML5NmL5fjAchpiOSwF8iwVyNXBcrJgOSgEcm8F8tgA3KWuQB5iWHZYII9EgTxBBPLAwnIeC-RxiPf_FXj_N6M-8_YrM3-dpltFF-t8llxmbk5TN48v3Tisrg7-OFKUT0PvdKcI-kGS_Vsu-xcj9Pl_L7szjN9Db-7L_irIfjJVlMHlo_Pxza__DN1ofoL2c4BP7Q091fyp5v8bzV_e1_zmR0_jMGdhFf785Mn9q_Hdj9zcT9zerU9fv_iE-_7G9-Nnvzwc_QvW7H8ebQsAAA&stq=1&cs=0&lei=pAjQZ8iHHeio4-EPg5i9oQs#",
        "videoUrl": "https://youtu.be/T0vBY9SNAWU?si=qWrfEQDzS645wgDG"
},
]


app.get("/video", (req, res) => {
    res.status(200).json(videos);
});

// Start the Server
const PORT = 5000;
app.listen(PORT, () => {
    console.log(` Server running on port ${PORT}`);
});
