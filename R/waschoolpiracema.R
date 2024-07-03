#' waschoolpiracema: Brazilian National School Census
#'
#' Since 2014 INEP (Instituto National de Estudos e Pesquisas Educacionais Anísio Teixeira), the Brazilian government entity responsible for the surveillance of schools, has been collecting and releasing information on an annual basis on the infrastructure of all basic education institutions in the country, regardless of the level of education, locality (rural vs urban) and management model (private or public) (INEP, 2021). Every year, the school's principals, headteachers, or the person in charge must reply to a self-reported survey sent by the INEP. The questionnaire contains 62 questions and should be filled out between June and August, considering the last Wednesday of May as the reference date for data collection (INEP, 2021). The final results are released at the end of January and the beginning of February from the following year. For the year 2020, due to the extraordinary situation of the COVID-19 pandemic, the reference date for collecting the data was postponed to March 11 2020, one day before the national closure of schools was established. Hence, the 2020 BNSC dataset describes the state of schools' infrastructure in Brazil right before they were closed. For 2021 and 2022, the reference date for data collection returned to the original standard (last Wednesday of May of 2021 and 2022). Thus, the 2021 BNSC, which were released on February 18 2022 reflect the impacts of the pandemic and the school closure on the state of schools' infrastructure in Brazil, while the 2022 BNSC released on and February 08 2023 indicates the situation of schools at the end of the pandemic.
#' We adopted the word "pre" to designate the state of schools before the beginning of the pandemic  (2020 BNSC), "peri" to refer to the state of schools during the pandemic (2021 BNSC) and "post" to indicate the conditions of schools moving forward from the COVID-19 pandemic (at the end of the pandemic).
#'
#' @format A tibble with 21 rows and 36 variables
#' \describe{
#'   \item{year}{Year of Survey}
#'   \item{sch_id}{Numerical code of the school}
#'   \item{admin}{The administration of the school is federal (1); state (2); municipal (3), or private (4). Federal, state, and municipal schools are considered public.}
#'   \item{loc}{The school is located in an urban (1) or rural area (2)}
#'   \item{drink_water}{The school provides drinking water with quality suitable for human consumption (i.e., ingestion, preparation, and production of food) according to the Brazilian national water quality standards (former Portaria nº 2.914/2011 now Portaria de Consolidação nº5/2017) (1 – Yes; 0 – No)}
#'   \item{public_water}{The water in the school is supplied by a public network (1 – Yes; 0 – No).  }
#'   \item{borehole_water}{The water in the school is supplied by a borehole (1 – Yes; 0 – No)}
#'   \item{well_water}{The water in the school is supplied by a cacimba, cistern, or well (1 – Yes; 0 – No)}
#'   \item{surface_water}{The water in the school is supplied by surface water source (1 – Yes; 0 – No)}
#'   \item{no_water}{There is no water supply in the school (1 – Yes; 0 – No) }
#'   \item{sewage_rede_publica}{The school dispose their sewage into a public sewerage system (1 – Yes; 0 – No)}
#'   \item{sewage_fossa_septica}{The school dispose their sewage into  septic tank (1 – Yes; 0 – No)}
#'   \item{waste_servico_coleta}{The solid waste in the school is regularly collected by the public cleaning service (1 – Yes; 0 – No)}
#'   \item{waste_queima}{The solid waste in the school is disposed in an area licensed by environmental agencies, intended to receive solid waste in a planned manner (e.g., landfills) (1 – Yes; 0 – No)}
#'   \item{waste_enterra}{The solid waste in the school is burned or incinerated (1 – Yes; 0 – No)}
#'   \item{waste_destino_final_publico}{The solid waste in the school is buried (1 – Yes; 0 – No)}
#'   \item{waste_descarta_outra_area}{The solid waste in the school is disposed in another area (none of the other options) (1 – Yes; 0 – No)}
#'   \item{sanitary}{The school is equipped with sanitary facilities for personal hygiene/physiological needs (1 – Yes; 0 – No)}
#'   \item{sanitary_ei}{The school is equipped with sanitary facilities for children 0 to 5 years old (1 – Yes; 0 – No)}
#'   \item{sanitary_pne}{The school is equipped with disability-friendly sanitary facilities following the national guidelines (ABNT - NBR 9050) (1 – Yes; 0 – No)}
#'   \item{sanitary_funcionarios}{The school is equipped with  sanitary facilities for personal hygiene/physiological needs exclusively for staff (1 – Yes; 0 – No)}
#'   \item{sanitary_chuveiro}{The school is equipped with  sanitary facilities or changing room or washing room with appropriate equipment (shower) for bathing, exclusively for students (1 – Yes; 0 – No)}
#'   \item{qt_mat_bas}{Total number of students per school}
#'   \item{pc_girl}{Percentage of girls per school}
#'   \item{pc_boy}{Percentage of boys per school}
#'   \item{pc_white}{Percentage of students that are classified or self-identified as white race/skin color per school}
#'   \item{pc_brown}{Percentage of students that are classified or self-identified as black race/skin color per school}
#'   \item{pc_black}{Percentage of students that are classified or self-identified as brown race/skin color per school}
#'   \item{pc_indian}{Percentage of students that are classified or self-identified as Asian race/skin color per school}
#'   \item{pc_asian}{Percentage of students that are classified or self-identified as indigenous race/skin color per school}
#'   \item{pc_nd}{Percentage of students that did not declared race/skin color per school}
#'   \item{pc_cre}{Percentage of students in daycare (0 - 3 years old)}
#'   \item{pc_pre}{Percentage of students in preschool (4 - 5 years old)}
#'   \item{pc_prim_1}{Percentage of students in primary education first cycle (6 - 10 years old)}
#'   \item{pc_prim_2}{Percentage of students in primary education second cycle (11 - 14 years old)}
#'   \item{pc_sec}{Percentage of students in secondary education (15 - 18 years old)}
#' }
"waschoolpiracema"
