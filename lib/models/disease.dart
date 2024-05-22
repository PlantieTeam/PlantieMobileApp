class Disease {
  final String name;
  final String description;
  final String image;
  final List<String> tips;
  final String medicine;
  const Disease({
    required this.name,
    required this.description,
    required this.image,
    required this.tips,
    required this.medicine,
  });
}

const List<Disease> dbDiseasesEN = [
  Disease(
      name: 'apple scab',
      description:
          "Apple scab is a fungal disease that affects apple trees and fruits. It's caused by the fungus Venturia inaequalis. The disease causes lesions to develop on the leaves,fruits, and sometimes even twigs of the apple tre",
      image: 'assets/images/disease/apple_scab.png',
      tips: [
        'Choose Resistant Varieties: Opt for apple varieties known for their resistance to apple scab. This is the single most effective preventative measure.',
        'Leaf Litter Management: Remove fallen leaves from the orchard floor after leaves have dropped in fall. Fallen leaves can harbor the fungus over winter, increasing the risk of infection in the following season.'
      ],
      medicine: 'score 250 EC'),
  Disease(
      name: 'apple cedar rust',
      description:
          "Apple cedar rust is a fungal disease that requires both apple trees and Eastern redcedar (Juniperus virginiana) trees to complete its life cycle. The fungus alternates between these two hosts, causing damage to both.",
      image: 'assets/images/disease/apple_cedar_rust.png',
      tips: [
        'Choose Resistant Varieties: Opt for apple varieties known for their resistance to apple scab. This is the single most effective preventative measure.',
        'Leaf Litter Management: Remove fallen leaves from the orchard floor after leaves have dropped in fall. Fallen leaves can harbor the fungus over winter, increasing the risk of infection in the following season.'
      ],
      medicine: 'score 250 EC'),
];

const List<Disease> dbDiseasesAR = [
  Disease(
      name: 'جرب التفاح',
      description:
          "جرب التفاح (داء الجرب التفاحي) هو مرض فطري يصيب أشجار التفاح وثمارها. يسببه الفطر Venturia inaequalis. يسبب المرض تكون آفات على أوراق الثمار وأحيانًا حتى أغصان شجرة التفاح",
      image: 'assets/images/disease/apple_scab.png',
      tips: [
        'اختيار أصناف مقاومة: اختر أنواع التفاح المعروفة بمقاومتها لجرب التفاح. يعد هذا أكثر إجراء وقائي فعالية. استشر مشاتل محلية أو خدمات الإرشاد الزراعي للحصول على توصيات بشأن الأصناف المقاومة والمناسبة لمناخيط ظروف الزراعة في منطقتك.',
        'إدارة بقايا الأوراق: قم بإزالة الأوراق المتساقطة من أرض البستان بعد سقوط الأوراق في الخريف. يمكن أن تأوي الأوراق المتساقطة الفطر خلال فصل الشتاء، مما يزيد من خطر الإصابة في الموسم التالي.'
      ],
      medicine: 'score 250 EC'),
  Disease(
      name: 'صدأ التفاح',
      description:
          "صدأ الأرز التفاحي هو مرض فطري يصيب أشجار التفاح , تظهر بقع برتقالية أو صفراء أو حمراء ذات حواف محددة على الأوراق",
      image: 'assets/images/disease/apple_cedar_rust.png',
      tips: [
        'اختيار أصناف مقاومة: اختر أنواع التفاح المعروفة بمقاومتها لجرب التفاح. يعد هذا أكثر إجراء وقائي فعالية. استشر مشاتل محلية أو خدمات الإرشاد الزراعي للحصول على توصيات بشأن الأصناف المقاومة والمناسبة لمناخيط ظروف الزراعة في منطقتك.',
        'إدارة بقايا الأوراق: قم بإزالة الأوراق المتساقطة من أرض البستان بعد سقوط الأوراق في الخريف. يمكن أن تأوي الأوراق المتساقطة الفطر خلال فصل الشتاء، مما يزيد من خطر الإصابة في الموسم التالي.'
      ],
      medicine: 'score 250 EC'),
];
