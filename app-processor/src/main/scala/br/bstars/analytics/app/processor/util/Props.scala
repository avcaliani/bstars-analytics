package br.bstars.analytics.app.processor.util

import java.util.Properties

import scala.util.Try

/**
 * Properties Trait.
 */
object Props extends Serializable {

  private val properties: Properties = {
    val p = new Properties()
    p.load(getClass.getResourceAsStream("/app.properties"))
    p
  }

  /**
   * Return a property value based on property {@code key}.
   * It throws an {@link RuntimeException} if property key doesn't exist.
   *
   * @param key Property Key.
   * @return Property Value.
   */
  def get(key: String): String =
    Try(properties.getProperty(key)).getOrElse(
      throw new RuntimeException(s"'$key' key not found in properties file!")
    )

}
