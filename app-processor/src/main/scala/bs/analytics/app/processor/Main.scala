package bs.analytics.app.processor

import org.apache.spark.sql.SparkSession

object Main {
  def main(args: Array[String]): Unit = {
    val spark = SparkSession.builder().getOrCreate()
    println(s"Spark Version: ${spark.version}")
    spark.close()
    sys.exit(0)
  }
}
