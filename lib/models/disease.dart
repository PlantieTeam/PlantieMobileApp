class Disease {
  final String name;
  final String description;
  final List<String> image;
  final List<String> tips;
  final String medicine;
  final bool isHealthy;
  const Disease({
    required this.name,
    required this.description,
    required this.image,
    required this.tips,
    required this.medicine,
    this.isHealthy = false,
  });
}

const List<Disease> dbDiseasesEN = [
  Disease(
      name: 'apple scab',
      description:
          "Apple scab is a fungal disease that affects apple trees and fruits. It's caused by the fungus Venturia inaequalis. The disease causes lesions to develop on the leaves,fruits, and sometimes even twigs of the apple tre",
      image: [
        'assets/images/disease/apple_scab (1).jpg',
        'assets/images/disease/apple_scab (2).jpg',
      ],
      tips: [
        'Choose Resistant Varieties: Opt for apple varieties known for their resistance to apple scab. This is the single most effective preventative measure.',
        'Leaf Litter Management: Remove fallen leaves from the orchard floor after leaves have dropped in fall. Fallen leaves can harbor the fungus over winter, increasing the risk of infection in the following season.'
      ],
      medicine: 'score 250 EC'),
  Disease(
      name: 'Apple Black rot',
      description:
          "Apple frogeye spot is a fungal disease caused by the fungus Botryosphaeria obtusa. This fungus can also infect other fruits like pomegranates and stone fruits like peaches, but it's particularly problematic for apple trees.",
      image: [
        'assets/images/disease/apple___Black_rot (1).jpg'
            'assets/images/disease/apple___Black_rot (2).jpg'
      ],
      tips: [
        'Sanitation: Remove fallen leaves and debris from the orchard floor after leaves have dropped in fall. This helps reduce overwintering inoculum (fungal spores) that can cause new infections the following season.'
            'Watering Practices: Avoid overhead watering, as this can promote moisture on leaves, creating a more favorable environment for fungal growth. Irrigate at the base of the trees instead'
      ],
      medicine: 'score 250 EC'),
  Disease(
      name: 'apple cedar rust',
      description:
          "Apple cedar rust is a fungal disease that requires both apple trees and Eastern redcedar (Juniperus virginiana) trees to complete its life cycle. The fungus alternates between these two hosts, causing damage to both.",
      image: [
        'assets/images/disease/apple_cedar_rust (1).jpg',
        'assets/images/disease/apple_cedar_rust (2).jpg'
      ],
      tips: [
        'Choose Resistant Varieties: Opt for apple varieties known for their resistance to apple scab. This is the single most effective preventative measure.',
        'Leaf Litter Management: Remove fallen leaves from the orchard floor after leaves have dropped in fall. Fallen leaves can harbor the fungus over winter, increasing the risk of infection in the following season.'
      ],
      medicine: 'score 250 EC'),

  Disease(
    isHealthy: true,
    name: "Apple Healthy",
    description: "Apple is healthy",
    image: [],
    tips: [""],
    medicine: "",
  ),
  Disease(
      name: 'bean angular spot',
      description:
          "It is one of the most important diseases of beans in protected greenhouses in humid and semi-humid areas, affecting leaves, pods, stems, and leaf petioles. The disease spreads during the winter and spring at temperatures ranging from 16 to 28 degrees Celsius and high humidity, with the optimal temperature being 24 degrees Celsius.",
      image: [
        'assets/images/disease/bean_angular_spot (1).jpg',
        'assets/images/disease/bean_angular_spot (2).jpg',
      ],
      tips: [
        " Collecting residues from the previous season and disposing of them properly by burning them. ",
        "Deep plowing effectively reduces the source of infection. "
            "Using healthy, sterilized seeds or sterilizing the seeds before planting"
      ],
      medicine: 'score 250 EC'),
  Disease(
    isHealthy: true,
    name: "Bean Healthy",
    description: "Bean is healthy",
    image: ["assets/images/apple.png"],
    tips: [""],
    medicine: "",
  ),
  Disease(
      name: 'bean rust',
      description:
          "It is a disease that affects beans inside protected greenhouses and open fields during the spring and late autumn. The disease subsides during the hot summer months when temperatures rise above 28°C. It has been found that temperatures below 16°C in winter prevent the germination of uridial spores, and symptoms of the disease do not appear on the leaves. This disease causes significant economic losses to beans in infected greenhouses.",
      image: [
        'assets/images/disease/bean_rust (1).jpg',
        'assets/images/disease/bean_rust (2).jpg',
      ],
      tips: [
        "Complete cleanliness and disposal of bean residues from the previous season by burning them and deep plowing the soil leads to a significant reduction in the source of infection. Good monitoring during the growing season, especially in early autumn and early spring, when the average temperature ranges from 16-24°C, are the conditions under which infections occur to determine an effective spraying program.",
        "Pesticide spraying should commence when two rust spots appear on the bean leaf, with spraying repeated every 7 days under normal weather conditions and every 5 days in increased humidity. ",
        "Among the most important pesticides used are Bravo and Plantvax."
      ],
      medicine: 'score 250 EC'),
  Disease(
      name: 'Corn Cercospora leaf spot Gray leaf spot',
      description:
          "common fungal disease in the United States caused by the pathogen Cercospora zeae-maydis in corn",
      image: [
        'assets/images/disease/corn_cercospora_leaf_spot_gray_leaf_spot (1).jpg',
        'assets/images/disease/corn_cercospora_leaf_spot_gray_leaf_spot (2).jpg',
      ],
      tips: [
        "Planting resistant corn varieties",
        "Rotating fungicides (if necessary)",
        "Proper field sanitation (removing debris)",
        "Monitoring crops for early signs of infection"
      ],
      medicine: 'score 250 EC'),
  Disease(
    name: 'Northern Leaf Blight',
    description:
        'A fungal disease affecting corn, causing elongated lesions with wavy margins on leaves.',
    image: [
      'assets/images/disease/northern_leaf_blight (1).jpg',
      'assets/images/disease/northern_leaf_blight (2).jpg'
    ],
    tips: [
      'Rotate crops',
      'Practice good sanitation',
      'Apply fungicides if necessary'
    ],
    medicine: 'score 250 EC',
  ),
  Disease(
      name: 'Corn Common Rust',
      description:
          'A fungal disease that affects corn plants, characterized by orange-brown pustules on leaves.',
      image: [
        'assets/images/disease/corn_common_rust (1).jpg',
        'assets/images/disease/corn_common_rust (2).jpg',
      ],
      tips: [
        'Plant resistant corn varieties',
        'Remove and destroy infected leaves',
        'Apply fungicides'
      ],
      medicine: 'score 250 EC'),
  Disease(
    isHealthy: true,
    name: "Corn Healthy",
    description: "Corn is healthy",
    image: [],
    tips: [""],
    medicine: "",
  ),

  Disease(
    name: "Cucumber Anthracnose",
    description:
        "It is a fungal disease that affects all parts of the plant's vegetative mass, spreading at temperatures ranging from 22 to 27°C in spring. It also spreads rapidly after infection occurs",
    image: [
      'assets/images/disease/cucumber_anthracnose (1).jpg',
      'assets/images/disease/cucumber_anthracnose (2).jpg'
    ],
    tips: [
      "Sterilizing greenhouse soil through solar sterilization or using suitable chemical sterilizers. ",
      "Utilizing mulching to isolate sources of infection. ",
      "Using healthy seeds from unaffected fruits and seedlings from reliable sources."
    ],
    medicine: 'score 250 EC',
  ),

  Disease(
    name: 'Cucumber Gummy Stem Blight',
    description:
        'A fungal disease causing water-soaked lesions on stems and leaves, exuding a gummy substance.',
    image: [
      'assets/images/disease/cucumber_gummy_stem_blight (1).jpg',
      'assets/images/disease/cucumber_gummy_stem_blight (2).jpg'
    ],
    tips: ['Rotate crops', 'Remove infected plants', 'Apply fungicide'],
    medicine: 'score 250 EC',
  ),
  Disease(
    isHealthy: true,
    name: "Cucumber Healthy",
    description: "Cucumber is healthy",
    image: ["assets/images/apple.png"],
    tips: [""],
    medicine: "",
  ),
  Disease(
    name: 'Grape Black Rot',
    description:
        'A fungal disease causing black spots on grape leaves and shriveled grapes.',
    image: [
      'assets/images/disease/grape_black_rot (1).jpg',
      'assets/images/disease/grape_black_rot (2).jpg'
    ],
    tips: [
      "Practice excellent sanitation. When black rot appears, begin sanitation cleanup at once, writing off the current crop.",
      "In late winter, just before buds begin to break open, remove all of the previous season’s fruit-bearing stems, which can harbor disease, and begin a spray program.",
      "Make sure you provide good air movement around and in between the vines."
    ],
    medicine: 'switch',
  ),
  Disease(
    name: 'Grape Esca (Black Measles)',
    description:
        'A fungal disease causing dark streaks in wood and spots on leaves and grapes.',
    image: [
      'assets/images/disease/grape_esca (1).jpg',
      'assets/images/disease/grape_esca (2).jpg'
    ],
    tips: [
      "Avoid pruning during periods of heavy rainfall when spores are likely to be dispersed",
      "Monitor the vineyard in Spring, and look for dead spurs or for stunted shoots. Later in summer, cut off cankered portions of the vine",
      "Remove diseased debris from the vineyard and destroy them."
    ],
    medicine: 'score 250 EC',
  ),
  Disease(
    name: 'Grape Leaf Blight (Isariopsis Leaf Spot)',
    description:
        'A fungal disease causing dark, angular spots on grape leaves.',
    image: [
      'assets/images/disease/grape_leaf_blight (1).jpg',
      'assets/images/disease/grape_leaf_blight (2).jpg'
    ],
    tips: [
      "Apply dormant sprays to reduce inoculum levels",
      'Ensure good air circulation',
      'remove as much inoculum as possible, either by chopping up the prunings and burning them or burying large trunks to destroy fungal pathogens.'
    ],
    medicine: 'score 250 EC',
  ),
  Disease(
    isHealthy: true,
    name: "Grape Healthy",
    description: "Grape is healthy",
    image: ["assets/images/apple.png"],
    tips: [""],
    medicine: "",
  ),

  Disease(
    name: 'Pepper Bell Bacterial Spot',
    description:
        'A bacterial disease causing water-soaked spots on leaves and fruit of pepper plants.',
    image: [
      'assets/images/disease/pepper_bell_bacterial_spot (1).jpg',
      'assets/images/disease/pepper_bell_bacterial_spot (2).jpg'
    ],
    tips: [
      'Use disease-free seeds',
      'Apply copper-based bactericides',
      'Rotate crops'
    ],
    medicine: 'score 250 EC',
  ),
  Disease(
    isHealthy: true,
    name: "Pepper Bell Healthy",
    description: "Pepper Bell is healthy",
    image:[ "assets/images/apple.png"],
    tips: [""],
    medicine: "",
  ),
  Disease(
    name: 'Potato Early Blight',
    description:
        'A fungal disease of potato that causes concentric rings on leaves and tubers.',
    image: [
      'assets/images/disease/potato_early_blight (1).jpg',
      'assets/images/disease/potato_early_blight (2).jpg'
    ],
    tips: ['Rotate crops', 'Remove infected debris', 'Apply fungicide'],
    medicine: 'score 250 EC',
  ),
  Disease(
    name: 'Potato Late Blight',
    description:
        'A serious disease of potato caused by a fungus-like organism, leading to brown lesions on leaves and tubers.',
    image: [
      'assets/images/disease/potato_late_blight (1).jpg',
      'assets/images/disease/potato_late_blight (2).jpg'
    ],
    tips: [
      'Use resistant varieties',
      'Remove and destroy infected plants',
      'Apply fungicide'
    ],
    medicine: 'score 250 EC',
  ),
  Disease(
    isHealthy: true,
    name: "Potato Healthy",
    description: "Potato is healthy",
    image: ["assets/images/apple.png"],
    tips: [""],
    medicine: "",
  ),
  Disease(
    name: 'Strawberry Leaf Scorch',
    description:
        'A fungal disease causing irregular brown spots on strawberry leaves, leading to leaf scorch.',
    image: [
      'assets/images/disease/strawberry_leaf_scorch (1).jpg',
      'assets/images/disease/strawberry_leaf_scorch (2).jpg'
    ],
    tips: [
      'Remove infected leaves',
      'Ensure good air circulation',
      'Apply fungicide'
    ],
    medicine: 'score 250 EC',
  ),
  Disease(
    isHealthy: true,
    name: "Strawberry Healthy",
    description: "Strawberry is healthy",
    image: ["assets/images/apple.png"],
    tips: [""],
    medicine: "",
  ),
  Disease(
    name: 'Tomato Bacterial Spot',
    description:
        'A bacterial disease causing small, water-soaked spots on tomato leaves and fruit.',
    image: [
      'assets/images/disease/tomato_bacterial_spot (1).jpg',
      'assets/images/disease/tomato_bacterial_spot (2).jpg'
    ],
    tips: [
      'Use disease-free seeds',
      'Apply copper-based bactericides',
      'Rotate crops'
    ],
    medicine: 'score 250 EC',
  ),
  //Tomato Early blight  && Tomato Late blight
  Disease(
    name: 'Tomato Early blight',
    description:
        'A bacterial disease causing small, water-soaked spots on tomato leaves and fruit.',
    image: [
      'assets/images/disease/tomato_early_blight (1).jpg',
      'assets/images/disease/tomato_early_blight (2).jpg'
    ],
    tips: [
      'Use disease-free seeds',
      'Apply copper-based bactericides',
      'Rotate crops'
    ],
    medicine: 'score 250 EC',
  ),
  Disease(
    name: 'Tomato Late blight',
    description:
        "Early blight disease is one of the most important diseases of tomatoes in open fields and protected greenhouses. It mainly spreads in humid to semi-arid climates when dew drops are available at night and in the evening",
    image:[
      'assets/images/disease/tomato_late_blight (1).jpg',
      'assets/images/disease/tomato_late_blight (2).jpg'
    ],
    tips: [
      "Planting seedlings from healthy and disease-free seeds, or sterilizing the seeds and soaking them in hot water (70 degrees Celsius for 20 minutes).",
      "Removing crop residues and deep plowing reduce the incidence of disease. ",
      "Sterilization with disinfectants such as sodium methanolate at a rate of 4 liters per hectare."
    ],
    medicine: 'score 250 EC',
  ),
  //
  Disease(
    name: 'Tomato Leaf Mold',
    description:
        'A fungal disease causing yellow spots on the upper leaf surface and mold on the underside.',
    image: [
      'assets/images/disease/tomato_leaf_mold (1).jpg',
      'assets/images/disease/tomato_leaf_mold (2).jpg'
    ],
    tips: [
      'Improve air circulation',
      'Apply fungicide',
      'Avoid overhead watering'
    ],
    medicine: 'score 250 EC',
  ),
  Disease(
    name: 'Tomato Septoria Leaf Spot',
    description:
        'A fungal disease that causes small, circular spots on tomato leaves.',
    image: [
      'assets/images/disease/tomato_septoria_leaf_spot (1).jpg',
      'assets/images/disease/tomato_septoria_leaf_spot (2).jpg'
    ],
    tips: [
      'Remove infected leaves',
      'Avoid overhead watering',
      'Apply fungicides'
    ],
    medicine: 'score 250 EC',
  ),
  Disease(
    name: 'Tomato Spider Mites (Two-Spotted Spider Mite)',
    description:
        'Tiny pests that cause yellowing and speckling of tomato leaves.',
    image: [
      'assets/images/disease/tomato_spider_mites (1).jpg',
      'assets/images/disease/tomato_spider_mites (2).jpg'
    ],
    tips: [
      'Use insecticidal soap',
      'Introduce natural predators',
      'Maintain adequate moisture'
    ],
    medicine: 'score 250 EC',
  ),
  // Tomato Target Spot & Tomato Tomato mosaic virus
  Disease(
    name: 'Tomato Target Spot',
    description:
        'Tiny pests that cause yellowing and speckling of tomato leaves.',
    image: [
      'assets/images/disease/tomato_target_spot (1).jpg',
      'assets/images/disease/tomato_target_spot (2).jpg'
    ],
    tips: [
      'Use insecticidal soap',
      'Introduce natural predators',
      'Maintain adequate moisture'
    ],
    medicine: 'score 250 EC',
  ),
  Disease(
    name: 'Tomato mosaic virus',
    description:
        'Tiny pests that cause yellowing and speckling of tomato leaves.',
    image: [
      'assets/images/disease/tomato_mosaic_virus (1).jpg',
      'assets/images/disease/tomato_mosaic_virus (2).jpg'
    ],
    tips: [
      'Use insecticidal soap',
      'Introduce natural predators',
      'Maintain adequate moisture'
    ],
    medicine: 'score 250 EC',
  ),
  Disease(
    isHealthy: true,
    name: "Tomato Healthy",
    description: "Tomato is healthy",
    image: ["assets/images/apple.png"],
    tips: [""],
    medicine: "",
  ),
  //
  Disease(
    name: 'olive aculus olearius',
    description:
        'A fungal disease affecting olive trees, causing dark circular spots on leaves.',
    image: [
      'assets/images/disease/olive_aculus_olearius (1).jpg',
      'assets/images/disease/olive_aculus_olearius (2).jpg' 
    ],
    tips: [
      'Prune affected branches',
      'Ensure good air circulation',
      'Apply copper-based fungicides'
    ],
    medicine: 'score 250 EC',
  ),
  Disease(
    isHealthy: true,
    name: "Olive Healthy",
    description: "Olive is healthy",
    image: [],
    tips: [""],
    medicine: "",
  ),
  Disease(
    name: 'Olive Peacock Spot',
    description:
        'A fungal disease affecting olive trees, causing dark circular spots on leaves.',
    image: [
      'assets/images/disease/olive_peacock_spot (1).jpg',
      'assets/images/disease/olive_peacock_spot (2).jpg'      
    ],
    tips: [
      'Prune affected branches',
      'Ensure good air circulation',
      'Apply copper-based fungicides'
    ],
    medicine: 'funguran',
  ),
];
const List<Disease> dbDiseasesAR = [
  Disease(
      name: 'جرب التفاح',
      description:
          "جرب التفاح هو مرض فطري يؤثر على أشجار التفاح والفواكه. يسببه الفطر Venturia inaequalis. يتسبب المرض في ظهور آفات على الأوراق والفواكه وأحيانًا على أغصان شجرة التفاح.",
         image: [
        'assets/images/disease/apple_scab (1).jpg',
        'assets/images/disease/apple_scab (2).jpg',
      ],
      tips: [
        'اختيار الأصناف المقاومة: اختر أصناف التفاح المعروفة بمقاومتها لجرب التفاح. هذا هو الإجراء الوقائي الأكثر فعالية.',
        'إدارة بقايا الأوراق: إزالة الأوراق المتساقطة من أرض البستان بعد سقوط الأوراق في الخريف. يمكن أن تأوي الأوراق المتساقطة الفطر خلال الشتاء، مما يزيد من خطر الإصابة في الموسم التالي.'
      ],
      medicine: 'score 250 EC'),
      Disease(
      name: 'بقعة العين الضفدعية في التفاح',
      description:
          "بقعة العين الضفدعية في التفاح هي مرض فطري يسببه الفطر Botryosphaeria obtusa. يمكن أن يصيب هذا الفطر أيضًا الفواكه الأخرى مثل الرمان والفواكه الحجرية مثل الخوخ، لكنه يمثل مشكلة خاصة لأشجار التفاح.",
          image: [
        'assets/images/disease/apple___Black_rot (1).jpg'
            'assets/images/disease/apple___Black_rot (2).jpg'
      ],
      tips: [
        'الصيانة: إزالة الأوراق المتساقطة والحطام من أرض البستان بعد سقوط الأوراق في الخريف. هذا يساعد في تقليل الفطريات التي قد تسبب إصابات جديدة في الموسم التالي.',
        'ممارسات الري: تجنب الري العلوي، حيث يمكن أن يعزز الرطوبة على الأوراق، مما يخلق بيئة أكثر ملاءمة لنمو الفطريات. قم بالري عند قاعدة الأشجار بدلاً من ذلك.'
      ],
      medicine: 'score 250 EC'),
  Disease(
      name: 'صدأ التفاح والأرز',
      description:
          "صدأ التفاح والأرز هو مرض فطري يتطلب وجود كل من أشجار التفاح وأشجار الأرز الشرقي (Juniperus virginiana) لإكمال دورة حياته. يتنقل الفطر بين هذين المضيفين، مما يسبب أضرارًا لكليهما.",
   image: [
        'assets/images/disease/apple_cedar_rust (1).jpg',
        'assets/images/disease/apple_cedar_rust (2).jpg'
      ],
      tips: [
        'اختيار الأصناف المقاومة: اختر أصناف التفاح المعروفة بمقاومتها لجرب التفاح. هذا هو الإجراء الوقائي الأكثر فعالية.',
        'إدارة بقايا الأوراق: إزالة الأوراق المتساقطة من أرض البستان بعد سقوط الأوراق في الخريف. يمكن أن تأوي الأوراق المتساقطة الفطر خلال الشتاء، مما يزيد من خطر الإصابة في الموسم التالي.'
      ],
      medicine: 'score 250 EC'),
  
  Disease(
    isHealthy: true,
    name: "تفاح صحي",
    description: "التفاح صحي",
    image:[ "assets/images/apple.png"],
    tips: [""],
    medicine: "",
  ),
  Disease(
      name: 'بقعة الزاوية في الفاصوليا',
      description:
          "إنه أحد أهم أمراض الفاصوليا في البيوت المحمية في المناطق الرطبة وشبه الرطبة، حيث يؤثر على الأوراق والقرون والسيقان والأعناق. ينتشر المرض خلال الشتاء والربيع في درجات حرارة تتراوح بين 16 إلى 28 درجة مئوية ورطوبة عالية، حيث تكون درجة الحرارة المثلى هي 24 درجة مئوية.",
      image: [
        'assets/images/disease/bean_angular_spot (1).jpg',
        'assets/images/disease/bean_angular_spot (2).jpg',
      ],
      tips: [
        "جمع بقايا الموسم السابق والتخلص منها بشكل صحيح عن طريق حرقها.",
        "الحراثة العميقة تقلل بشكل فعال من مصدر العدوى.",
        "استخدام بذور صحية ومعقمة أو تعقيم البذور قبل الزراعة."
      ],
      medicine: 'score 250 EC'),
  Disease(
    isHealthy: true,
    name: "فاصوليا صحية",
    description: "الفاصوليا صحية",
    image: ["assets/images/apple.png"],
    tips: [""],
    medicine: "",
  ),
  Disease(
      name: 'صدأ الفاصوليا',
      description:
          "هو مرض يصيب الفاصوليا داخل البيوت المحمية والحقول المفتوحة خلال الربيع وأواخر الخريف. يخف المرض خلال أشهر الصيف الحارة عندما ترتفع درجات الحرارة فوق 28 درجة مئوية. وجد أن درجات الحرارة أقل من 16 درجة مئوية في الشتاء تمنع إنبات الجراثيم، ولا تظهر أعراض المرض على الأوراق. يسبب هذا المرض خسائر اقتصادية كبيرة للفاصوليا في البيوت المحمية المصابة.",
      image: [
        'assets/images/disease/bean_rust (1).jpg',
        'assets/images/disease/bean_rust (2).jpg',
      ],
      tips: [
        "النظافة التامة والتخلص من بقايا الفاصوليا من الموسم السابق عن طريق حرقها والحراثة العميقة للتربة تؤدي إلى تقليل كبير في مصدر العدوى. مراقبة جيدة خلال موسم النمو، خاصة في أوائل الخريف وأوائل الربيع، عندما تتراوح درجة الحرارة بين 16-24 درجة مئوية، وهي الظروف التي تحدث فيها الإصابات لتحديد برنامج رش فعال.",
        "يجب أن تبدأ الرش بالمبيدات عندما تظهر بقعتين صدأ على ورقة الفاصوليا، مع تكرار الرش كل 7 أيام في الظروف الجوية العادية وكل 5 أيام في الرطوبة المتزايدة.",
        "من بين أهم المبيدات المستخدمة هي Bravo وPlantvax."
      ],
      medicine: 'score 250 EC'),
  Disease(
      name: 'بقعة الأوراق سيركوسبورا في الذرة',
      description:
          "مرض فطري شائع في الولايات المتحدة تسببه الممرض Cercospora zeae-maydis في الذرة.",
      image: [
        'assets/images/disease/corn_cercospora_leaf_spot_gray_leaf_spot (1).jpg',
        'assets/images/disease/corn_cercospora_leaf_spot_gray_leaf_spot (2).jpg',
      ],
      tips: [
        "زراعة أصناف الذرة المقاومة.",
        "تناوب المبيدات الفطرية (إذا لزم الأمر).",
        "النظافة الجيدة في الحقل (إزالة الحطام).",
        "مراقبة المحاصيل لأعراض العدوى المبكرة."
      ],
      medicine: 'score 250 EC'),
      Disease(
    name: 'اللفحة الشمالية للأوراق',
    description:
        'مرض فطري يصيب الذرة، يسبب ظهور آفات طويلة بحواف متموجة على الأوراق.',
    image: [
      'assets/images/disease/northern_leaf_blight (1).jpg',
      'assets/images/disease/northern_leaf_blight (2).jpg'
    ],
    tips: [
      'تناوب المحاصيل.',
      'ممارسة النظافة الجيدة.',
      'تطبيق المبيدات الفطرية إذا لزم الأمر.'
    ],
    medicine: 'score 250 EC',
  ),
  Disease(
      name: 'صدأ الذرة الشائع',
      description:
          'مرض فطري يصيب نباتات الذرة، يتميز بظهور بثور برتقالية-بنية على الأوراق.',
      image: [
        'assets/images/disease/corn_common_rust (1).jpg',
        'assets/images/disease/corn_common_rust (2).jpg',
      ],
      tips: [
        'زراعة أصناف الذرة المقاومة.',
        'إزالة الأوراق المصابة وتدميرها.',
        'تطبيق المبيدات الفطرية.'
      ],
      medicine: 'score 250 EC'),
  
  Disease(
    isHealthy: true,
    name: "ذرة صحية",
    description: "الذرة صحية",
    image: ["assets/images/apple.png"],
    tips: [""],
    medicine: "",
  ),
  Disease(
    name: "أنثراكنوز الخيار",
    description:
        "هو مرض فطري يصيب جميع أجزاء الكتلة الخضرية للنبات، ينتشر في درجات حرارة تتراوح بين 22 إلى 27 درجة مئوية في الربيع. ينتشر أيضًا بسرعة بعد حدوث العدوى.",
    image: [
      'assets/images/disease/cucumber_anthracnose (1).jpg',
      'assets/images/disease/cucumber_anthracnose (2).jpg'
    ],
    tips: [
      "تعقيم تربة الدفيئة من خلال التعقيم الشمسي أو استخدام المعقمات الكيميائية المناسبة.",
      "استخدام التغطية لعزل مصادر العدوى.",
      "استخدام بذور صحية من ثمار غير مصابة وشتلات من مصادر موثوقة."
    ],
    medicine: 'score 250 EC',
  ),
  Disease(
    name: 'مرض اللثة في ساق الخيار',
    description:
        'مرض فطري يسبب آفات مبللة بالماء على السيقان والأوراق، تطلق مادة صمغية.',
    image: [
      'assets/images/disease/cucumber_gummy_stem_blight (1).jpg',
      'assets/images/disease/cucumber_gummy_stem_blight (2).jpg'
    ],
    tips: [
      'تناوب المحاصيل',
      'إزالة النباتات المصابة',
      'تطبيق المبيدات الفطرية'
    ],
    medicine: 'score 250 EC',
  ),
  Disease(
    isHealthy: true,
    name: "خيار صحي",
    description: "الخيار صحي",
    image:[ "assets/images/apple.png"],
    tips: [""],
    medicine: "",
  ),
  Disease(
    name: 'تعفن العنب الأسود',
    description: 'مرض فطري يسبب بقع سوداء على أوراق العنب وتجعد العنب.',
    image: [
      'assets/images/disease/grape_black_rot (1).jpg',
      'assets/images/disease/grape_black_rot (2).jpg'
    ],
    tips: [
      "ممارسة النظافة الممتازة. عند ظهور التعفن الأسود، ابدأ في تنظيف البستان فورًا، متجاهلاً المحصول الحالي.",
      "في أواخر الشتاء، قبل أن تبدأ البراعم في التفتح، قم بإزالة جميع السيقان المثمرة من الموسم السابق، التي قد تأوي المرض، وابدأ برنامج الرش.",
      "تأكد من توفير تهوية جيدة حول وبين الكروم."
    ],
    medicine: 'switch',
  ),
  Disease(
    name: 'إيسكا العنب (الحصبة السوداء)',
    description:
        'مرض فطري يسبب ظهور خطوط داكنة في الخشب وبقع على الأوراق والعنب.',
    image: [
      'assets/images/disease/grape_esca (1).jpg',
      'assets/images/disease/grape_esca (2).jpg'
    ],
    tips: [
      "تجنب التقليم خلال فترات هطول الأمطار الغزيرة عندما تكون الأبواغ منتشرة.",
      "راقب الكرم في الربيع، وابحث عن الفروع الميتة أو البراعم المتوقفة. في وقت لاحق من الصيف، اقطع الأجزاء المصابة من الكرمة.",
      "أزل الحطام المصاب من الكرم ودمره."
    ],
    medicine: 'score 250 EC',
  ),
  Disease(
    name: 'اللفحة الورقية في العنب (بقعة الأوراق الإساريوبسية)',
    description: 'مرض فطري يسبب بقع داكنة وزاوية على أوراق العنب.',
    image: [
      'assets/images/disease/grape_leaf_blight (1).jpg',
      'assets/images/disease/grape_leaf_blight (2).jpg'
    ],
    tips: [
      "تطبيق الرش الوقائي لتقليل مستويات العدوى.",
      'تأكد من تهوية جيدة.',
      'إزالة أكبر قدر ممكن من العدوى، إما عن طريق تقطيع الأفرع وحرقها أو دفن الجذوع الكبيرة لتدمير الفطريات.'
    ],
    medicine: 'score 250 EC',
  ),
  Disease(
    isHealthy: true,
    name: "عنب صحي",
    description: "العنب صحي",
    image: ["assets/images/apple.png"],
    tips: [""],
    medicine: "",
  ),
  Disease(
    name: 'بقعة البكتيريا في الفلفل الحلو',
    description:
        'مرض بكتيري يسبب بقع مبللة بالماء على أوراق وثمار نباتات الفلفل.',
    image: [
      'assets/images/disease/pepper_bell_bacterial_spot (1).jpg',
      'assets/images/disease/pepper_bell_bacterial_spot (2).jpg'
    ],
    tips: [
      'استخدام بذور خالية من الأمراض.',
      'تطبيق المبيدات البكتيرية القائمة على النحاس.',
      'تناوب المحاصيل.'
    ],
    medicine: 'score 250 EC',
  ),
  Disease(
    isHealthy: true,
    name: "فلفل حلو صحي",
    description: "الفلفل الحلو صحي",
    image:[ "assets/images/apple.png"],
    tips: [""],
    medicine: "",
  ),
  Disease(
    name: 'اللفحة المبكرة في البطاطا',
    description:
        'مرض فطري يصيب البطاطا يسبب حلقات متحدة المركز على الأوراق والدرنات.',
    image: [
      'assets/images/disease/potato_early_blight (1).jpg',
      'assets/images/disease/potato_early_blight (2).jpg'
    ],
    tips: ['تناوب المحاصيل', 'إزالة الحطام المصاب', 'تطبيق المبيدات الفطرية'],
    medicine: 'score 250 EC',
  ),
  Disease(
    name: 'اللفحة المتأخرة في البطاطا',
    description:
        'مرض خطير يصيب البطاطا يسببه كائن شبيه بالفطريات، يؤدي إلى ظهور آفات بنية على الأوراق والدرنات.',
    image: [
      'assets/images/disease/potato_late_blight (1).jpg',
      'assets/images/disease/potato_late_blight (2).jpg'
    ],
    tips: [
      'استخدام أصناف مقاومة.',
      'إزالة النباتات المصابة وتدميرها.',
      'تطبيق المبيدات الفطرية.'
    ],
    medicine: 'score 250 EC',
  ),
  Disease(
    isHealthy: true,
    name: "بطاطا صحية",
    description: "البطاطا صحية",
    image: ["assets/images/apple.png"],
    tips: [""],
    medicine: "",
  ),
  Disease(
    name: 'حرق الأوراق في الفراولة',
    description:
        'مرض فطري يسبب بقع بنية غير منتظمة على أوراق الفراولة، مما يؤدي إلى احتراق الأوراق.',
    image: [
      'assets/images/disease/strawberry_leaf_scorch (1).jpg',
      'assets/images/disease/strawberry_leaf_scorch (2).jpg'
    ],
    tips: [
      'إزالة الأوراق المصابة.',
      'تأكد من تهوية جيدة.',
      'تطبيق المبيدات الفطرية.'
    ],
    medicine: 'score 250 EC',
  ),
  Disease(
    isHealthy: true,
    name: "فراولة صحية",
    description: "الفراولة صحية",
    image: ["assets/images/apple.png"],
    tips: [""],
    medicine: "",
  ),
  Disease(
    name: 'بقعة البكتيريا في الطماطم',
    description:
        'مرض بكتيري يسبب بقع صغيرة مبللة بالماء على أوراق وثمار الطماطم.',
    image: [
      'assets/images/disease/tomato_bacterial_spot (1).jpg',
      'assets/images/disease/tomato_bacterial_spot (2).jpg'
    ],
    tips: [
      'استخدام بذور خالية من الأمراض.',
      'تطبيق المبيدات البكتيرية القائمة على النحاس.',
      'تناوب المحاصيل.'
    ],
    medicine: 'score 250 EC',
  ),
  Disease(
    name: 'اللفحة المبكرة في الطماطم',
    description:
        'مرض بكتيري يسبب بقع صغيرة مبللة بالماء على أوراق وثمار الطماطم.',
    image: [
      'assets/images/disease/tomato_early_blight (1).jpg',
      'assets/images/disease/tomato_early_blight (2).jpg'
    ],
    tips: [
      'استخدام بذور خالية من الأمراض.',
      'تطبيق المبيدات البكتيرية القائمة على النحاس.',
      'تناوب المحاصيل.'
    ],
    medicine: 'score 250 EC',
  ),
  Disease(
    name: 'اللفحة المتأخرة في الطماطم',
    description:
        "مرض اللفحة المبكرة هو أحد أهم أمراض الطماطم في الحقول المفتوحة والبيوت المحمية. ينتشر بشكل رئيسي في المناخات الرطبة إلى شبه الجافة عند توفر ندى الليل والنهار.",
    image:[
      'assets/images/disease/tomato_late_blight (1).jpg',
      'assets/images/disease/tomato_late_blight (2).jpg'
    ],
    tips: [
      "زراعة الشتلات من بذور صحية وخالية من الأمراض، أو تعقيم البذور ونقعها في ماء ساخن (70 درجة مئوية لمدة 20 دقيقة).",
      "إزالة بقايا المحاصيل والحراثة العميقة تقلل من نسبة الإصابة بالمرض.",
      "التعقيم بالمطهرات مثل ميثانولات الصوديوم بمعدل 4 لترات لكل هكتار."
    ],
    medicine: 'score 250 EC',
  ),
  Disease(
    name: 'عفن الأوراق في الطماطم',
    description:
        'مرض فطري يسبب بقع صفراء على السطح العلوي للأوراق وعفن على الجانب السفلي.',
    image: [
      'assets/images/disease/tomato_leaf_mold (1).jpg',
      'assets/images/disease/tomato_leaf_mold (2).jpg'
    ],
    tips: ['تحسين التهوية.', 'تطبيق المبيدات الفطرية.', 'تجنب الري العلوي.'],
    medicine: 'score 250 EC',
  ),
  Disease(
    name: 'بقعة الأوراق السبتورية في الطماطم',
    description: 'مرض فطري يسبب بقع دائرية صغيرة على أوراق الطماطم.',
    image: [
      'assets/images/disease/tomato_septoria_leaf_spot (1).jpg',
      'assets/images/disease/tomato_septoria_leaf_spot (2).jpg'
    ],
    tips: [
      'إزالة الأوراق المصابة.',
      'تجنب الري العلوي.',
      'تطبيق المبيدات الفطرية.'
    ],
    medicine: 'score 250 EC',
  ),
  Disease(
    name: 'العنكبوت الأحمر في الطماطم (سوس العنكبوت ذو البقعتين)',
    description: 'آفات صغيرة تسبب اصفرار وبقع على أوراق الطماطم.',
    image: [
      'assets/images/disease/tomato_spider_mites (1).jpg',
      'assets/images/disease/tomato_spider_mites (2).jpg'
    ],
    tips: [
      'استخدام صابون المبيدات الحشرية.',
      'إدخال المفترسات الطبيعية.',
      'الحفاظ على رطوبة كافية.'
    ],
    medicine: 'score 250 EC',
  ),
  Disease(
    name: 'بقعة الهدف في الطماطم',
    description: 'آفات صغيرة تسبب اصفرار وبقع على أوراق الطماطم.',
    image: [
      'assets/images/disease/tomato_target_spot (1).jpg',
      'assets/images/disease/tomato_target_spot (2).jpg'
    ],
    tips: [
      'استخدام صابون المبيدات الحشرية.',
      'إدخال المفترسات الطبيعية.',
      'الحفاظ على رطوبة كافية.'
    ],
    medicine: 'Pyridaben',
  ),
  Disease(
    name: 'فيروس موزاييك الطماطم',
    description: 'آفات صغيرة تسبب اصفرار وبقع على أوراق الطماطم.',
    image: [
      'assets/images/disease/tomato_mosaic_virus (1).jpg',
      'assets/images/disease/tomato_mosaic_virus (2).jpg'
    ],
    tips: [
      'استخدام صابون المبيدات الحشرية.',
      'إدخال المفترسات الطبيعية.',
      'الحفاظ على رطوبة كافية.'
    ],
    medicine: 'Dursban',
  ),
  Disease(
    isHealthy: true,
    name: "طماطم صحية",
    description: "الطماطم صحية",
    image: ["assets/images/apple.png"],
    tips: [""],
    medicine: "",
  ),
  Disease(
    name: 'اكولوس الزيتون',
    description:
        'مرض فطري يصيب أشجار الزيتون، يسبب بقع دائرية داكنة على الأوراق.',
    image: [
      'assets/images/disease/olive_aculus_olearius (1).jpg',
      'assets/images/disease/olive_aculus_olearius (2).jpg' 
    ],
    tips: [
      'تقليم الفروع المصابة.',
      'تأكد من تهوية جيدة.',
      'تطبيق المبيدات الفطرية القائمة على النحاس.'
    ],
    medicine: 'score 250 EC',
  ),
  Disease(
    isHealthy: true,
    name: "زيتون صحي",
    description: "الزيتون صحي",
    image: ["assets/images/apple.png"],
    tips: [""],
    medicine: "",
  ),
  Disease(
    name: 'بقعة الطاووس في الزيتون',
    description:
        'مرض فطري يصيب أشجار الزيتون، يسبب بقع دائرية داكنة على الأوراق.',
    image: [
      'assets/images/disease/olive_peacock_spot (1).jpg',
      'assets/images/disease/olive_peacock_spot (2).jpg'      
    ],
    tips: [
      'تقليم الفروع المصابة.',
      'تأكد من تهوية جيدة.',
      'تطبيق المبيدات الفطرية القائمة على النحاس.'
    ],
    medicine: 'funguran',
  ),
];
