from sacrebleu import corpus_bleu, corpus_chrf
from indicnlp.tokenize import indic_tokenize
import sys

def tokenize_urdu(text_lines):
    return [' '.join(indic_tokenize.trivial_tokenize(line, lang='ur')) for line in text_lines]

def evaluate(reference_path, translated_path, label):
    # Load data from text files
    with open(reference_path, "r", encoding="utf-8") as ref_file:
        references = [line.strip() for line in ref_file if line.strip()]

    with open(translated_path, "r", encoding="utf-8") as hyp_file:
        hypotheses = [line.strip() for line in hyp_file if line.strip()]

    # Sanity check
    if len(references) != len(hypotheses):
        raise ValueError(f"Mismatch in line count for {label}: {len(references)} refs vs {len(hypotheses)} hyps")

    # Apply IndicNLP tokenization
    references_tok = tokenize_urdu(references)
    hypotheses_tok = tokenize_urdu(hypotheses)

    # BLEU Score
    bleu = corpus_bleu(hypotheses_tok, [references_tok])
    print(f"\n{label} - SacreBLEU Score: {bleu.score:.2f}")

    # CHRF++
    chrf = corpus_chrf(hypotheses_tok, [references_tok], word_order=2)
    print(f"{label} - CHRF++ Score: {chrf.score:.2f}")

def main():
    reference_path = "/home/f237809/Indic/datasets/testsets/testumc.urd_Arab"
    finetuned_path = "/home/f237809/Indic/datasets/Outputs/Trans-Tanz/umc.urd_Arab"
    baseline_path = "/home/f237809/Indic/datasets/Outputs/Base-Translated/umc.urd_Arab"

    print("Evaluating Baseline Translation:")
    evaluate(reference_path, baseline_path, "Baseline")

    print("\nEvaluating Fine-tuned Translation:")
    evaluate(reference_path, finetuned_path, "Fine-tuned")

    print("\nTranslation Quality Guide based on BLEU:")
    print("""0.0 to 0.1: Very poor
0.1 to 0.3: Poor to fair
0.3 to 0.5: Moderate
0.5 to 0.7: Good
0.7 to 0.9: Very good
0.9 to 1.0: Excellent""")

if __name__ == "__main__":
    main()
