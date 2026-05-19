import 'package:flutter/widgets.dart';

import '../models/recipe.dart';

const sampleRecipesEn = <Recipe>[
  Recipe(
    id: '1',
    title: 'Creamy Garlic Pasta',
    imageUrl:
        'https://images.unsplash.com/photo-1473093295043-cdd812d0e601?auto=format&fit=crop&w=1200&q=80',
    durationMinutes: 25,
    rating: 4.8,
    categoryKey: 'dinner',
    description:
        'A cozy and creamy pasta that is perfect for beginner cooks and quick weeknight dinners.',
    ingredients: [
      '250g pasta',
      '2 tbsp olive oil',
      '3 garlic cloves, minced',
      '1 cup cooking cream',
      '1/2 cup parmesan cheese',
      'Salt and black pepper',
      'Fresh parsley',
    ],
    steps: [
      'Boil pasta in salted water until al dente, then drain.',
      'Heat olive oil in a pan and saute garlic for 30 seconds.',
      'Add cream and simmer for 2 minutes on low heat.',
      'Stir in parmesan until smooth, then season with salt and pepper.',
      'Add cooked pasta and toss well.',
      'Top with parsley and serve warm.',
    ],
  ),
  Recipe(
    id: '2',
    title: 'Honey Glazed Salmon',
    imageUrl:
        'https://images.unsplash.com/photo-1467003909585-2f8a72700288?auto=format&fit=crop&w=1200&q=80',
    durationMinutes: 30,
    rating: 4.7,
    categoryKey: 'dinner',
    description:
        'Sweet, savory, and beginner-friendly salmon cooked with a simple honey soy glaze.',
    ingredients: [
      '2 salmon fillets',
      '2 tbsp honey',
      '2 tbsp soy sauce',
      '1 tbsp lemon juice',
      '1 garlic clove, minced',
      '1 tsp olive oil',
    ],
    steps: [
      'Mix honey, soy sauce, lemon juice, and garlic in a bowl.',
      'Brush salmon with olive oil and place in a hot pan.',
      'Cook for 3 minutes each side.',
      'Pour glaze into the pan and spoon over salmon until sticky.',
      'Serve with rice or steamed vegetables.',
    ],
  ),
  Recipe(
    id: '3',
    title: 'Avocado Toast Deluxe',
    imageUrl:
        'https://images.unsplash.com/photo-1525351484163-7529414344d8?auto=format&fit=crop&w=1200&q=80',
    durationMinutes: 10,
    rating: 4.6,
    categoryKey: 'breakfast',
    description:
        'A fresh breakfast classic with creamy avocado, lemon, and chili flakes.',
    ingredients: [
      '2 slices sourdough bread',
      '1 ripe avocado',
      '1 tsp lemon juice',
      'Pinch of salt',
      'Chili flakes',
      'Olive oil drizzle',
    ],
    steps: [
      'Toast bread slices until golden.',
      'Mash avocado with lemon juice and salt.',
      'Spread avocado on toast and add chili flakes.',
      'Finish with a light olive oil drizzle.',
    ],
  ),
  Recipe(
    id: '4',
    title: 'Classic Chicken Salad',
    imageUrl:
        'https://images.unsplash.com/photo-1546793665-c74683f339c1?auto=format&fit=crop&w=1200&q=80',
    durationMinutes: 20,
    rating: 4.5,
    categoryKey: 'lunch',
    description:
        'A bright and crunchy chicken salad with a simple homemade dressing.',
    ingredients: [
      '2 cups shredded cooked chicken',
      '2 cups mixed greens',
      '1 cucumber, sliced',
      '1 tomato, chopped',
      '2 tbsp olive oil',
      '1 tbsp lemon juice',
      'Salt and pepper',
    ],
    steps: [
      'Combine chicken and vegetables in a large bowl.',
      'Whisk olive oil, lemon juice, salt, and pepper.',
      'Pour dressing over salad and toss to coat.',
      'Serve immediately.',
    ],
  ),
];

const sampleRecipesAr = <Recipe>[
  Recipe(
    id: '1',
    title: 'باستا كريمية بالثوم',
    imageUrl:
        'https://images.unsplash.com/photo-1473093295043-cdd812d0e601?auto=format&fit=crop&w=1200&q=80',
    durationMinutes: 25,
    rating: 4.8,
    categoryKey: 'dinner',
    description:
        'باستا كريمية دافئة ومناسبة للمبتدئين، مثالية لوجبة عشاء سريعة خلال أيام الأسبوع.',
    ingredients: [
      '250 غرام باستا',
      '2 ملعقة كبيرة زيت زيتون',
      '3 فصوص ثوم مفروم',
      '1 كوب كريمة طبخ',
      '1/2 كوب جبن بارميزان',
      'ملح وفلفل أسود',
      'بقدونس طازج',
    ],
    steps: [
      'اسلق الباستا في ماء مملح حتى تنضج ثم صفّها.',
      'سخن زيت الزيتون في مقلاة وشوّح الثوم لمدة 30 ثانية.',
      'أضف الكريمة واتركها على نار هادئة لمدة دقيقتين.',
      'أضف البارميزان وحرّك حتى يصبح القوام ناعماً ثم تبّل بالملح والفلفل.',
      'أضف الباستا المسلوقة وقلّب جيداً.',
      'زيّن بالبقدونس وقدّمها ساخنة.',
    ],
  ),
  Recipe(
    id: '2',
    title: 'سلمون بصلصة العسل',
    imageUrl:
        'https://images.unsplash.com/photo-1467003909585-2f8a72700288?auto=format&fit=crop&w=1200&q=80',
    durationMinutes: 30,
    rating: 4.7,
    categoryKey: 'dinner',
    description:
        'طبق سلمون حلو ومالح بطريقة سهلة للمبتدئين مع صلصة بسيطة من العسل والصويا.',
    ingredients: [
      '2 فيليه سلمون',
      '2 ملعقة كبيرة عسل',
      '2 ملعقة كبيرة صلصة صويا',
      '1 ملعقة كبيرة عصير ليمون',
      '1 فص ثوم مفروم',
      '1 ملعقة صغيرة زيت زيتون',
    ],
    steps: [
      'اخلط العسل والصويا وعصير الليمون والثوم في وعاء.',
      'ادهن السلمون بزيت الزيتون وضعه في مقلاة ساخنة.',
      'اطهِ كل جهة لمدة 3 دقائق.',
      'أضف الصلصة إلى المقلاة واسقِ بها السلمون حتى تتماسك.',
      'قدّمه مع الأرز أو الخضار المطهوة بالبخار.',
    ],
  ),
  Recipe(
    id: '3',
    title: 'توست أفوكادو فاخر',
    imageUrl:
        'https://images.unsplash.com/photo-1525351484163-7529414344d8?auto=format&fit=crop&w=1200&q=80',
    durationMinutes: 10,
    rating: 4.6,
    categoryKey: 'breakfast',
    description:
        'فطور طازج وسريع مع أفوكادو كريمي ولمسة ليمون ورقائق فلفل حار.',
    ingredients: [
      '2 شريحة خبز ساوردو',
      '1 حبة أفوكادو ناضجة',
      '1 ملعقة صغيرة عصير ليمون',
      'رشة ملح',
      'رقائق فلفل حار',
      'رشة زيت زيتون',
    ],
    steps: [
      'حمّص شرائح الخبز حتى تصبح ذهبية.',
      'اهرِس الأفوكادو مع عصير الليمون والملح.',
      'افرد الأفوكادو على الخبز وأضف رقائق الفلفل.',
      'أنهِ الوصفة برشة خفيفة من زيت الزيتون.',
    ],
  ),
  Recipe(
    id: '4',
    title: 'سلطة دجاج كلاسيكية',
    imageUrl:
        'https://images.unsplash.com/photo-1546793665-c74683f339c1?auto=format&fit=crop&w=1200&q=80',
    durationMinutes: 20,
    rating: 4.5,
    categoryKey: 'lunch',
    description: 'سلطة دجاج خفيفة ومقرمشة مع تتبيلة منزلية بسيطة ومنعشة.',
    ingredients: [
      '2 كوب دجاج مطبوخ ومفتت',
      '2 كوب خضار ورقية مشكلة',
      '1 خيار مقطع',
      '1 طماطم مقطعة',
      '2 ملعقة كبيرة زيت زيتون',
      '1 ملعقة كبيرة عصير ليمون',
      'ملح وفلفل',
    ],
    steps: [
      'اخلط الدجاج والخضار في وعاء كبير.',
      'اخفق زيت الزيتون مع عصير الليمون والملح والفلفل.',
      'أضف التتبيلة إلى السلطة وقلّب جيداً.',
      'قدّمها مباشرة.',
    ],
  ),
];

List<Recipe> sampleRecipesForLocale(Locale locale) {
  return locale.languageCode == 'ar' ? sampleRecipesAr : sampleRecipesEn;
}
