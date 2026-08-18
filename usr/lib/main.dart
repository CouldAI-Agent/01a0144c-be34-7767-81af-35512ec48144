import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RSA Cryptography',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueGrey,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const RsaPresentationScreen(),
      },
    );
  }
}

class RsaPresentationScreen extends StatefulWidget {
  const RsaPresentationScreen({super.key});

  @override
  State<RsaPresentationScreen> createState() => _RsaPresentationScreenState();
}

class _RsaPresentationScreenState extends State<RsaPresentationScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<SlideData> _slides = [
    SlideData(
      title: "Welcome to RSA Cryptography",
      icon: Icons.security,
      content: [
        const SlideSection(
          title: "Topic Name",
          body: "Public-Key Asymmetric Cryptography (The RSA Algorithm)",
        ),
        const SlideSection(
          title: "Inventors",
          body: "Ron Rivest, Adi Shamir, and Leonard Adleman (1977 at MIT)",
        ),
        const SlideSection(
          title: "Core Concept",
          body:
              "Uses a dual-key mechanism. A Public Key locks (encrypts) data openly, while a mathematically linked Private Key unlocks (decrypts) it secretly. Security is anchored on the computational difficulty of factoring massive prime products.",
        ),
      ],
    ),
    SlideData(
      title: "Mathematical Infrastructure Setup",
      icon: Icons.calculate,
      content: [
        const SlideSection(
          title: "Step 1: Choose Starting Primes (p, q)",
          body:
              "Select two distinct prime integers. For our standard demonstration, we use:\np = 11 and q = 13",
        ),
        const SlideSection(
          title: "Step 2: Calculate the Base Modulus (n)",
          body:
              "Multiply both primes. This boundary acts as a container limit for transmission values.\nFormula: n = p × q ⇒ 11 × 13 = 143",
        ),
        const SlideSection(
          title: "Step 3: Calculate Euler's Totient Helper Number (φ)",
          body:
              "Find how many coprime whole integers exist below n via a prime shortcut deduction rule:\nFormula: φ = (p - 1) × (q - 1) ⇒ (11 - 1) × (13 - 1) = 10 × 12 = 120",
        ),
      ],
    ),
    SlideData(
      title: "Asymmetric Key Generation",
      icon: Icons.key,
      content: [
        const SlideSection(
          title: "Step 4: Select the Public Encryption Key (e)",
          body:
              "The Selection Rule: Test our safe prime integer line (3, 5, 7, 11, 13...) on a calculator. Pick the first odd prime value where dividing φ leaves an uneven decimal point answer (meaning they are coprime).\n\n120 ÷ 3 = 40 (Whole integer) ×\n120 ÷ 5 = 24 (Whole integer) ×\n120 ÷ 7 = 17.14 (Decimal point boundary matched!) ⇒ Choose e = 7",
        ),
        const SlideSection(
          title: "Step 5: Calculate the Secret Private Decryption Key (d)",
          body:
              "The Add-and-Divide Formula: d = ((k × φ) + 1) ÷ e. We step up k (1, 2, 3...) until the product divides perfectly clean without decimals.\n\nk=1: (1×120)+1 = 121 ÷ 7 = 17.28 ×\nk=2: (2×120)+1 = 241 ÷ 7 = 34.42 ×\nk=5: (5×120)+1 = 601 ÷ 7 = 85.85 ×\nk=6: (6×120)+1 = 721 ÷ 7 = 103 (Clean integer match!) ⇒ Choose d = 103",
        ),
      ],
    ),
    SlideData(
      title: "Key Verification Check",
      icon: Icons.verified_user,
      content: [
        const SlideSection(
          title: "The Absolute Remainder Rule",
          body:
              "Before deployment, always verify keys using our Absolute Remainder Rule.\nThe Core Law: When the keys are multiplied together and divided by the helper number φ, the leftover remainder MUST ALWAYS BE EXACTLY 1.",
        ),
        const SlideSection(
          title: "Verification Steps",
          body:
              "1. Multiply Keys: e × d = 7 × 103 = 721\n2. Divide by Helper: 721 ÷ 120 = 6 whole times\n3. Check Leftover Remainder: 721 - (6 × 120) = 721 - 720 = 1\n\nBecause the leftover remainder is exactly 1, our key generation is 100% mathematically correct.",
        ),
      ],
    ),
    SlideData(
      title: "Plaintext Conversion & Encryption",
      icon: Icons.lock,
      content: [
        const SlideSection(
          title: "Step 6: Convert Text Message 'hi' into Digital Values",
          body:
              "Text letters must convert to raw baseline ASCII integer format values (m):\nLetter 'h' = 104 | Letter 'i' = 105",
        ),
        const SlideSection(
          title: "Step 7: Encrypt the Message (Locking)",
          body:
              "Sender locks the plain integers using the Public Key variables (e = 7, n = 143).\nFormula: Ciphertext (c) = m^e mod n\n\nLocking 'h' (104): 104^7 mod 143 = 91\nLocking 'i' (105): 105^7 mod 143 = 118\n\nThe scrambled ciphertext numbers [91, 118] are transmitted openly across networks. Intercepting hackers only see these arbitrary numeric sequences.",
        ),
      ],
    ),
    SlideData(
      title: "Decryption Flow & Retrieval",
      icon: Icons.lock_open,
      content: [
        const SlideSection(
          title: "Step 8: Decrypt the Ciphertext (Unlocking)",
          body:
              "The recipient intercepts the numbers [91, 118] and applies the secret Private Key parameters (d = 103, n = 143).\nFormula: Plaintext (m) = c^d mod n\n\nUnlocking '91': 91^103 mod 143 = 104 ⇒ Maps directly to letter 'h'\nUnlocking '118': 118^103 mod 143 = 105 ⇒ Maps directly to letter 'i'\n\nThe mathematical processes perfectly inverse each other, restructuring the scrambled numeric string smoothly back into the original intended message string: hi.",
        ),
      ],
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _prevPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RSA Explained'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemCount: _slides.length,
                itemBuilder: (context, index) {
                  return SlideView(slide: _slides[index]);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    onPressed: _currentPage > 0 ? _prevPage : null,
                    icon: const Icon(Icons.arrow_back),
                    label: const Text("Previous"),
                  ),
                  Text(
                    "Slide ${_currentPage + 1} of ${_slides.length}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  TextButton.icon(
                    onPressed:
                        _currentPage < _slides.length - 1 ? _nextPage : null,
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text("Next"),
                    iconAlignment: IconAlignment.end,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SlideData {
  final String title;
  final IconData icon;
  final List<SlideSection> content;

  SlideData({
    required this.title,
    required this.icon,
    required this.content,
  });
}

class SlideSection {
  final String title;
  final String body;

  const SlideSection({
    required this.title,
    required this.body,
  });
}

class SlideView extends StatelessWidget {
  final SlideData slide;

  const SlideView({super.key, required this.slide});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          slide.icon,
                          size: 40,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            slide.title,
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    ...slide.content.map((section) => Padding(
                          padding: const EdgeInsets.only(bottom: 24.0),
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    section.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    section.body,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(height: 1.5),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
