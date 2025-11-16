const functions = require("./scheme-model");

/*
  Eğer `scheme_id` veritabanında yoksa:

  durum 404
  {
    "message": "scheme_id <gerçek id> id li şema bulunamadı"
  }
*/
const checkSchemeId = async (req, res, next) => {
  try {
    const scheme = await functions.findById(req.params.scheme_id);
    if (!scheme) {
      return res.status(404).json({
        message: `scheme_id ${req.params.scheme_id} id li şema bulunamadı`,
      });
    }
    req.existScheme = scheme;
    next();
  } catch (err) {
    next(err);
  }
};

/*

};

/*
  Eğer `scheme_name` yoksa, boş string ya da string değil:

  durum 400
  {
    "message": "Geçersiz scheme_name"
  }
*/
const validateScheme = (req, res, next) => {
  try {
    const schemeName = req.body.scheme_name;
    if (!schemeName || typeof schemeName !== "string") {
      return res.status(400).json({ message: "Geçersiz scheme_name" });
    }
    next();
  } catch (err) {
    next(err);
  }
};

/*
  Eğer `instructions` yoksa, boş string yada string değilse, ya da
  eğer `step_number` sayı değilse ya da birden küçükse:

  durum 400
  {
    "message": "Hatalı step"
  }
*/
const validateStep = (req, res, next) => {
  try {
    const { instructions, step_number } = req.body;
    if (
      !instructions ||
      step_number === undefined ||
      typeof step_number !== "number" ||
      step_number < 1
    ) {
      return res.status(400).json({ message: "Hatalı step" });
    }
    next();
  } catch (err) {
    next(err);
  }
};

module.exports = {
  checkSchemeId,
  validateScheme,
  validateStep,
};
