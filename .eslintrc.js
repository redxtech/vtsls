module.exports = {
  root: true,
  extends: [
    "eslint:recommended",
    "plugin:@typescript-eslint/recommended-type-checked",
    "plugin:@typescript-eslint/stylistic-type-checked",
  ],
  parser: "@typescript-eslint/parser",
  parserOptions: {
    tsconfigRootDir: __dirname,
    project: ["./packages/server/tsconfig.json", "./packages/service/tsconfig.lint.json"],
  },
  plugins: ["@typescript-eslint"],
  ignorePatterns: [
    "packages/service/src/typescript-language-features",
    "packages/service/vscode",
    "packages/vscode-fuzzy",
    // TODO: specific rules for scripts file
    "packages/**/*.js",
    "packages/service/vitest.config.ts",
    "packages/service/tests/workspace",
    "**/dist",
    ".eslintrc.*",
  ],
  rules: {
    // "@typescript-eslint/ban-ts-comment": "warn",
    "@typescript-eslint/no-empty-function": "off",
    "@typescript-eslint/no-explicit-any": "off",
    "@typescript-eslint/no-this-alias": "off",
    "@typescript-eslint/no-unsafe-argument": "off",
    "@typescript-eslint/no-unsafe-assignment": "off",
    "@typescript-eslint/no-unsafe-member-access": "off",
    // "@typescript-eslint/no-unsafe-return": "warn",
    "@typescript-eslint/require-await": "off",
    // "@typescript-eslint/unbound-method": "warn",
    "@typescript-eslint/no-non-null-assertion": "off",
    "@typescript-eslint/array-type": "off",
  },
};
