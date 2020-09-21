package br.bstars.analytics.app.processor.util

/**
 * Convert Utils.
 * This is a utilities class to convert anything.
 */
object ConvertUtil {

  /**
   * This method converts camel case string to snake case string (upper case).
   *
   * @param value Value to be converted.
   * @return Converted value.
   */
  def toSnake(value: String): String =
    "[A-Z\\d]".r
      .replaceAllIn(value, m => "_" + m.group(0))
      .toLowerCase

}
