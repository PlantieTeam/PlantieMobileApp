String sendData(String message) {
  return message; // Placeholder for the actual send_data implementation
}

String checkWeatherConditions(String status, double temperature,
    double humidity, double windSpeed, double precipitation) {
  status = status == "Clear" ? "Sunny" : status;
  if (status == 'Sunny' && temperature > 30) {
    return sendData(
        'اليوم مشمس وحار، تأكد من ري النباتات بانتظام لتجنب الجفاف. من الأفضل ري النباتات في الصباح الباكر أو المساء لتجنب تبخر الماء.');
  }

  if (status == 'Cloudy' && temperature < 25 && humidity < 50) {
    return sendData(
        'اليوم غائم مع رطوبة منخفضة، اليوم مناسب لتطبيق الري. تأكد من مراقبة الرطوبة في التربة لتجنب الجفاف.');
  }

  if (status == 'Rainy' && temperature < 15) {
    return sendData(
        'اليوم ممطر وبارد، اليوم مناسب لتطبيق المبيدات الحشرية لحماية المحاصيل. تأكد من استخدام مبيدات مقاومة للماء.');
  }

  if (status == 'Sunny' && temperature > 35) {
    return sendData(
        'اليوم شديد الحرارة، تأكد من ري النباتات بكثرة وتوفير الظل لتجنب الإجهاد الحراري. يمكن استخدام الأغطية البلاستيكية لحماية النباتات.');
  }

  if (status == 'Windy' && temperature < 20) {
    return sendData(
        'اليوم عاصف وبارد، تأكد من حماية النباتات من الرياح القوية لتجنب التلف. استخدم الدعامات والأغطية لتثبيت النباتات.');
  }

  if (status == 'Foggy' && humidity > 80) {
    return sendData(
        'اليوم ضبابي مع رطوبة عالية، راقب النباتات لرصد أي علامات للعفن والآفات. استخدم المبيدات الفطرية إذا لزم الأمر.');
  }

  if (windSpeed > 20) {
    return sendData(
        'اليوم عاصف جداً، تأكد من تثبيت النباتات وتوفير الدعم لتجنب التكسر. يمكن استخدام الأغطية الشبكية لتقليل تأثير الرياح.');
  }

  if (precipitation > 10) {
    return sendData(
        'اليوم ممطر بكثافة، تأكد من تصريف المياه جيداً حول النباتات لمنع التعفن. استخدم نظام تصريف جيد لتجنب تجمع المياه.');
  }

  if (status == 'Snowy') {
    return sendData(
        'اليوم مثلج، قم بتغطية النباتات الحساسة وحمايتها من البرودة الشديدة. استخدم الأغطية البلاستيكية والمهاد لحماية الجذور.');
  }

  if (status == 'Thunderstorm') {
    return sendData(
        'اليوم عاصفة رعدية، تأكد من تثبيت كل الأشياء المتحركة وحماية النباتات من الضرر. قم بفصل المعدات الكهربائية لحمايتها من الصواعق.');
  }

  if (status == 'Hail') {
    return sendData(
        'اليوم تساقط البرد، احمي النباتات بغطاء أو قم بنقلها إلى مكان آمن. استخدم الأغطية البلاستيكية لحماية المحاصيل الحساسة.');
  }

  if (status == 'Sunny' && temperature > 30 && humidity < 40) {
    return sendData(
        'اليوم مشمس وحار وجاف، تأكد من زيادة تردد الري واستخدام الأسمدة العضوية لتعزيز مقاومة النباتات للجفاف.');
  }

  if (status == 'Cloudy' && temperature < 20 && humidity > 60) {
    return sendData(
        'اليوم غائم وبارد ورطب، تجنب الري الزائد واستخدم مبيدات فطرية وقائية لحماية النباتات من الأمراض الفطرية.');
  }

  if (status == 'Rainy' && windSpeed > 15) {
    return sendData(
        'اليوم ممطر وعاصف، تأكد من حماية النباتات الصغيرة والشتلات باستخدام دعامات أو أغطية بلاستيكية.');
  }

  if (status == 'Foggy' && temperature > 10) {
    return sendData(
        'اليوم ضبابي ودافئ، راقب ظهور الآفات الحشرية واستخدم مصائد الفرمونات أو مبيدات حشرية طبيعية.');
  }

  if (status == 'Sunny' && windSpeed > 20) {
    return sendData(
        'اليوم مشمس وعاصف، تأكد من ري النباتات بانتظام وتثبيتها جيدًا لتجنب التلف الناتج عن الرياح.');
  }

  if (status == 'Cloudy' && humidity > 70 && precipitation > 5) {
    return sendData(
        'اليوم غائم ورطب مع أمطار خفيفة، تأكد من تهوية البيوت البلاستيكية لمنع تكاثر الأمراض الفطرية.');
  }

  if (status == 'Rainy' && temperature > 20) {
    return sendData(
        'اليوم ممطر ودافئ، تأكد من مراقبة التربة لمنع تجمع المياه وتجنب تعفن الجذور.');
  }

  if (status == 'Windy' && humidity < 30) {
    return sendData(
        'اليوم عاصف وجاف، احمي النباتات من الجفاف باستخدام المهاد العضوي للحفاظ على رطوبة التربة.');
  }

  if (status == 'Snowy' && temperature < 0) {
    return sendData(
        'اليوم مثلج وبارد جداً، قم بتغطية النباتات الحساسة واستخدام المهاد لحماية الجذور من التجمد.');
  }

  if (status == 'Thunderstorm' && windSpeed > 25) {
    return sendData(
        'اليوم عاصفة رعدية وعواصف شديدة، تأكد من حماية النباتات والبنية التحتية الزراعية من الأضرار المحتملة.');
  }

  if (status == 'Hail' && temperature > 10) {
    return sendData(
        'اليوم تساقط البرد ودافئ، استخدم الأغطية البلاستيكية أو الأنفاق لحماية المحاصيل من الأضرار.');
  }
  return sendData('');
}

String checkWeatherConditionsEnglish(String status, double temperature,
    double humidity, double windSpeed, double precipitation) {
  status = status == "Clear" ? "Sunny" : status;

  if (status == 'Sunny' && temperature > 30) {
    return sendData(
        'It is sunny and hot today, make sure to water the plants regularly to avoid dehydration. It is better to water the plants early in the morning or in the evening to prevent water evaporation.');
  }

  if (status == 'Cloudy' && temperature < 25 && humidity < 50) {
    return sendData(
        'It is cloudy with low humidity today, a good day for irrigation. Be sure to monitor soil moisture to avoid dryness.');
  }

  if (status == 'Rainy' && temperature < 15) {
    return sendData(
        'It is rainy and cold today, a good day to apply insecticides to protect crops. Be sure to use water-resistant insecticides.');
  }

  if (status == 'Sunny' && temperature > 35) {
    return sendData(
        'It is very hot today, make sure to water the plants heavily and provide shade to avoid heat stress. Plastic covers can be used to protect the plants.');
  }

  if (status == 'Windy' && temperature < 20) {
    return sendData(
        'It is windy and cold today, make sure to protect the plants from strong winds to avoid damage. Use supports and covers to stabilize the plants.');
  }

  if (status == 'Foggy' && humidity > 80) {
    return sendData(
        'It is foggy with high humidity today, monitor plants for any signs of mold and pests. Use fungicides if necessary.');
  }

  if (windSpeed > 20) {
    return sendData(
        'It is very windy today, make sure to secure the plants and provide support to avoid breakage. Net covers can be used to reduce wind impact.');
  }

  if (precipitation > 10) {
    return sendData(
        'It is heavily rainy today, ensure good drainage around the plants to prevent rot. Use a good drainage system to avoid waterlogging.');
  }

  if (status == 'Snowy') {
    return sendData(
        'It is snowy today, cover sensitive plants and protect them from extreme cold. Use plastic covers and mulch to protect the roots.');
  }

  if (status == 'Thunderstorm') {
    return sendData(
        'It is a thunderstorm today, secure all movable items and protect the plants from damage. Disconnect electrical equipment to protect it from lightning.');
  }

  if (status == 'Hail') {
    return sendData(
        'It is hailing today, protect the plants with a cover or move them to a safe place. Use plastic covers to protect sensitive crops.');
  }

  if (status == 'Sunny' && temperature > 30 && humidity < 40) {
    return sendData(
        'It is sunny, hot, and dry today, increase the frequency of watering and use organic fertilizers to enhance plant resistance to drought.');
  }

  if (status == 'Cloudy' && temperature < 20 && humidity > 60) {
    return sendData(
        'It is cloudy, cold, and humid today, avoid overwatering and use preventive fungicides to protect plants from fungal diseases.');
  }

  if (status == 'Rainy' && windSpeed > 15) {
    return sendData(
        'It is rainy and windy today, make sure to protect small plants and seedlings using supports or plastic covers.');
  }

  if (status == 'Foggy' && temperature > 10) {
    return sendData(
        'It is foggy and warm today, monitor for insect pests and use pheromone traps or natural insecticides.');
  }

  if (status == 'Sunny' && windSpeed > 20) {
    return sendData(
        'It is sunny and windy today, make sure to water the plants regularly and secure them well to avoid wind damage.');
  }

  if (status == 'Cloudy' && humidity > 70 && precipitation > 5) {
    return sendData(
        'It is cloudy and humid with light rain today, ensure proper ventilation in greenhouses to prevent fungal disease proliferation.');
  }

  if (status == 'Rainy' && temperature > 20) {
    return sendData(
        'It is rainy and warm today, monitor the soil to prevent waterlogging and root rot.');
  }

  if (status == 'Windy' && humidity < 30) {
    return sendData(
        'It is windy and dry today, protect plants from dryness using organic mulch to maintain soil moisture.');
  }

  if (status == 'Snowy' && temperature < 0) {
    return sendData(
        'It is snowy and very cold today, cover sensitive plants and use mulch to protect roots from freezing.');
  }

  if (status == 'Thunderstorm' && windSpeed > 25) {
    return sendData(
        'It is a thunderstorm with severe winds today, make sure to protect plants and agricultural infrastructure from potential damage.');
  }

  if (status == 'Hail' && temperature > 10) {
    return sendData(
        'It is hailing and warm today, use plastic covers or tunnels to protect crops from damage.');
  }
  return "No data found";
}
