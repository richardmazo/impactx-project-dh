const { body } = require("express-validator");
const path = require("path");

module.exports = [
  body("category").notEmpty().withMessage("Debe elegir una categoría"),
  body("product")
    .notEmpty()
    .withMessage("Debe completar el nombre del producto/servicio"),
  body("desc")
    .notEmpty()
    .withMessage(
      "Debe completar el campo con la descripción del producto/servicio"
    ),
  body("price")
    .notEmpty()
    .withMessage("Debe ingresar el precio del producto/servicio"),

  body("image").custom((value, { req }) => {
    let file = req.file;
    let extensionesPermitidas = [".jpg", ".png", ".gif"];

    if (file) {
      let fileExtension = path.extname(file.originalname);
      if (!extensionesPermitidas.includes(fileExtension)) {
        throw new Error(
          `Extensiones permitidas: ${extensionesPermitidas.join(", ")}`
        );
      }
    }
    return true;
  }),
];
