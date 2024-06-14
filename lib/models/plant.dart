import 'package:equatable/equatable.dart';

class Plant extends Equatable {
  final String name;
  final String description;
  final String image;
  final List<int> npk;
  const Plant(
      {required this.name,
      required this.description,
      required this.image,
      required this.npk});

  @override
  List<Object?> get props => [name, description, image];
}

const List<Plant> dbPlants = [
  Plant(
    name: 'Apple',
    description:
        'A fruit-bearing tree known for producing apples. Commercial apple cultivation is widespread in various regions of Palestine, especially in the mountains and fertile plains. The trees require good care and suitable growth conditions, including regular fertilization and watering. Apples are usually planted in winter, with care taken to remove dry branches and manage potential pests and diseases.',
    image: 'assets/images/apple.png',
    npk: [50, 30, 40],
  ),
  Plant(
    name: 'Green Beans',
    description:
        'An herbaceous plant; beans are one of the important agricultural crops in Palestine. Green beans require fertile soil and moderate moisture to grow well. It is preferable to plant green beans in spring and autumn, where the weather is mild and suitable for plant growth.',
    npk: [50, 50, 25],
    image: 'assets/images/green-beans.png',
  ),
  Plant(
    npk: [100, 50, 50],
    name: 'Corn',
    description:
        'An annual plant that produces ears containing kernels, which are an important food source for humans and animals. Corn is widely cultivated in various regions of Palestine, where it is considered a staple crop.',
    image: 'assets/images/corn.png',
  ),
  Plant(
    npk: [175, 75, 50],
    name: 'Cucumber',
    description:
        'An herbaceous plant that produces fruits known as cucumbers. Cucumbers are warm-weather plants and require moderate temperatures to grow well. Cucumbers are usually planted in summer when the weather is warm and suitable for growth.',
    image: 'assets/images/cucumber.png',
  ),
  Plant(
    npk: [60, 40, 40],
    name: 'Grapes',
    description:
        'A climbing plant that produces clusters of fruits known as grapes. Grape cultivation is one of the main agricultural activities in Palestine, with large quantities produced for export and local consumption. Grapes are preferably planted in winter or spring, with care taken to provide support for the climbing plants.',
    image: 'assets/images/grapes.png',
  ),
  Plant(
    npk: [120, 60, 50],
    name: 'Pepper',
    description:
        'An herbaceous plant that produces fruits known as peppers. Peppers are warm-weather plants and require moderate temperatures and rich soil to grow well. Peppers are usually planted in summer when the weather is warm and suitable for growth.',
    image: 'assets/images/pepper.png',
  ),
  Plant(
    npk: [150, 60, 120],
    name: 'Potato',
    description:
        'An herbaceous plant that produces edible tubers known as potatoes. Potato cultivation is one of the main agricultural activities in Palestine, requiring well-drained soil and moderate moisture to grow well. Potatoes can be planted in spring or autumn.',
    image: 'assets/images/potato.png',
  ),
  Plant(
    npk: [70, 30, 50],
    name: 'Olives',
    description:
        'A perennial tree that produces fruits known as olives. Olive cultivation is one of the main agricultural activities in Palestine, with large quantities of olive oil produced for export and local consumption.',
    image: 'assets/images/olives.png',
  ),
  Plant(
    npk: [120, 60, 50],
    name: 'Tomato',
    description:
        'An herbaceous plant that produces edible fruits known as tomatoes. Tomato cultivation is common in Palestine, requiring well-drained soil and moderate moisture to grow well. Tomatoes can be planted in spring or summer.',
    image: 'assets/images/tomato.png',
  ),
  Plant(
    npk: [90, 40, 60],
    name: 'Strawberry',
    description:
        'An herbaceous plant that produces small fruits known as strawberries. Strawberry cultivation is common in Palestine, requiring rich and moderately moist soil to grow well. Strawberries can be planted in spring or autumn.',
    image: 'assets/images/strawberry.png',
  ),
];

const List<Plant> dbPlantsAr = [
  Plant(
      name: 'تفاح',
      description:
          'شجرة مثمرة تنتج الفواكه المعروفة بالتفاح. تعتبر الزراعة التجارية للتفاح منتشرة في مناطق مختلفة من فلسطين، خاصة في مناطق الجبال والسهول الخصبة. تحتاج الأشجار إلى رعاية جيدة وتوفير ظروف ملائمة للنمو، بما في ذلك التسميد الدوري والري المنتظم. يتم زراعة التفاح عادة في فصل الشتاء، ويجب الحرص على إزالة الأفرع الجافة والتخلص من الآفات والأمراض المحتملة',
      image: 'assets/images/apple.png',
      npk: [50, 30, 40]),
  Plant(
      name: 'فاصوليا',
      description:
          'نبات عشبي يُعتبر فاصوليا من أهم المحاصيل الزراعية في فلسطين. تحتاج الفاصوليا إلى تربة خصبة ومعتدلة الرطوبة للنمو بشكل جيد. يُفضل زراعة الفاصوليا في فصل الربيع والخريف، حيث يكون الطقس معتدلاً ومناسباً لنمو النبات',
      npk: [50, 50, 25],
      image: 'assets/images/green-beans.png'),
  Plant(
      npk: [100, 50, 50],
      name: 'ذرة',
      description:
          'نبات حولي ينتج سنابل تحتوي على حبوب تعتبر غذاءً هامًا للبشر والحيوانات. يتم زراعة الذرة بشكل واسع في مناطق مختلفة من فلسطين، حيث تُعتبر أحد المحاصيل الأساسية في الزراعة',
      image: 'assets/images/corn.png'),
  Plant(
      npk: [175, 75, 50],
      name: 'خيار',
      description:
          'نبات عشبي ينتج ثمارًا معروفة بالخيار. يعتبر الخيار من النباتات الدافئة ويحتاج إلى درجات حرارة معتدلة للنمو بشكل جيد. يتم زراعة الخيار في الصيف عادةً، حيث يكون الطقس دافئًا ومناسبًا للنمو',
      image: 'assets/images/cucumber.png'),
  Plant(
      npk: [60, 40, 40],
      name: 'عنب',
      description:
          'نبات متسلق ينتج عناقيد ثمار معروفة بالعنب. تُعتبر زراعة العنب من الزراعات الرئيسية في فلسطين، حيث يتم إنتاج العنب بكميات كبيرة للتصدير والاستهلاك المحلي يُفضل زراعة العنب في فصل الشتاء أو الربيع، ويجب الحرص على توفير الدعم اللازم للنباتات المتسلقة',
      image: 'assets/images/grapes.png'),
  Plant(
      npk: [120, 60, 50],
      name: 'فلفل',
      description:
          'نبات عشبي ينتج ثمارًا معروفة بالفلفل. يُعتبر الفلفل من النباتات الدافئة ويحتاج إلى درجات حرارة معتدلة وتربة غنية للنمو بشكل جيد. يُفضل زراعة الفلفل في الصيف عادةً، حيث يكون الطقس دافئًا ومناسبًا للنمو',
      image: 'assets/images/pepper.png'),
  Plant(
      npk: [150, 60, 120],
      name: 'بطاطا',
      description:
          'نبات عشبي ينتج جذورًا مأكولة تعرف بالبطاطا. تعتبر زراعة البطاطا من الزراعات الرئيسية في فلسطين، حيث تحتاج إلى تربة جيدة التصريف ومعتدلة الرطوبة للنمو بشكل جيد. يمكن زراعة البطاطا في الربيع أو الخريف',
      image: 'assets/images/potato.png'),
  Plant(
      npk: [70, 30, 50],
      name: 'زيتون',
      description:
          'شجرة معمرة تنتج ثمارًا معروفة بالزيتون. تُعتبر زراعة الزيتون من الزراعات الرئيسية في فلسطين، حيث يتم إنتاج زيت الزيتون بكميات كبيرة للتصدير والاستهلاك المحلي',
      image: 'assets/images/olives.png'),
  Plant(
      npk: [120, 60, 50],
      name: 'بندورة',
      description:
          'نبات عشبي ينتج ثمارًا مأكولة تعرف بالبندورة. تُعتبر زراعة البندورة من الزراعات الشائعة في فلسطين، حيث تحتاج إلى تربة جيدة التصريف ومعتدلة الرطوبة للنمو بشكل جيد. يمكن زراعة البندورة في الربيع أو الصيف',
      image: 'assets/images/tomato.png'),
  Plant(
      npk: [90, 40, 60],
      name: 'فراولة',
      description:
          'نبات عشبي ينتج ثمارًا صغيرة معروفة بالفراولة. تُعتبر زراعة الفراولة من الزراعات الشائعة في فلسطين، حيث تحتاج إلى تربة غنية ومعتدلة الرطوبة للنمو بشكل جيد. يمكن زراعة الفراولة في الربيع أو الخريف',
      image: 'assets/images/strawberry.png'),
];
