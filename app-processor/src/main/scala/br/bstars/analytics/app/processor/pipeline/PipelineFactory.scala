package br.bstars.analytics.app.processor.pipeline

import br.bstars.analytics.app.processor.pipeline.raw.RawPipeline
import br.bstars.analytics.app.processor.pipeline.refined.RefinedPipeline
import br.bstars.analytics.app.processor.pipeline.trusted.TrustedPipeline
import org.apache.spark.sql.SparkSession

/**
 * Pipeline Factory.
 * This object will decide which Pipeline will be used.
 */
object PipelineFactory {

  /**
   * Return a Pipeline instance.
   * If the pipeline name is invalid an exception will be raised.
   *
   * @param spark        Spark Session.
   * @param pipelineName Pipeline Name.
   * @return Pipeline Instance.
   */
  def instance(spark: SparkSession, pipelineName: String): Pipeline = {
    val name = if (pipelineName == null) "UNDEFINED" else pipelineName.toUpperCase()
    name match {
      case "RAW"     => new RawPipeline(spark)
      case "TRUSTED" => new TrustedPipeline(spark)
      case "REFINED" => new RefinedPipeline(spark)
      case _         => throw new RuntimeException(s"Pipeline name is not valid! [$name]")
    }
  }

}
