#!/usr/bin/env python3

import argparse
import os
import sys

import tskit


def process_trees(trees_path, outprefix):
    """
    Read a tskit .trees file and generate:

        {outprefix}_coal_dist.csv
        {outprefix}_branch_length_dist.csv

    The coalescent file contains each unique non-sample node once.

    The branch-length file contains every branch in every marginal
    tree in the tree sequence.
    """

    # ------------------------------------------------------------
    # Load tree sequence
    # ------------------------------------------------------------
    print(f"Loading tree sequence: {trees_path}")

    try:
        ts = tskit.load(trees_path)
    except Exception as e:
        print("ERROR: Could not load tree sequence.")
        print(e)
        sys.exit(1)

    print("Loaded tree sequence:")
    print(f"  Samples:         {ts.num_samples}")
    print(f"  Nodes:           {ts.num_nodes}")
    print(f"  Trees:           {ts.num_trees}")
    print(f"  Sequence length: {ts.sequence_length}")

    # ------------------------------------------------------------
    # Output filenames
    # ------------------------------------------------------------
    coal_dist_path = f"{outprefix}_coal_dist.csv"
    branch_length_dist_path = f"{outprefix}_branch_length_dist.csv"

    # Create output directory if necessary
    outdir = os.path.dirname(os.path.abspath(outprefix))

    if outdir:
        os.makedirs(outdir, exist_ok=True)

    # ------------------------------------------------------------
    # Write coalescent times
    # ------------------------------------------------------------
    print(f"Writing coalescent times: {coal_dist_path}")

    with open(coal_dist_path, "w") as f:
        f.write("Node, generations\n")

        for u in range(ts.num_nodes):
            node = ts.node(u)

            # Exclude sample nodes (leaves)
            if node.flags & tskit.NODE_IS_SAMPLE:
                continue

            f.write(f"Node {u}, {node.time}\n")

    # ------------------------------------------------------------
    # Write branch lengths
    # ------------------------------------------------------------
    print(f"Writing branch lengths: {branch_length_dist_path}")

    with open(branch_length_dist_path, "w") as f:
        f.write("node_generations, branch_length\n")

        for tree in ts.trees():

            for u in tree.nodes():

                p = tree.parent(u)

                # Root has no parent
                if p == tskit.NULL:
                    continue

                node_generations = tree.time(u)
                branch_length = tree.time(p) - node_generations

                f.write(
                    f"{node_generations}, {branch_length}\n"
                )

    print("\nFinished.")
    print(f"  {coal_dist_path}")
    print(f"  {branch_length_dist_path}")


def main():

    parser = argparse.ArgumentParser(
        description=(
            "Generate coalescent-time and branch-length CSV files "
            "from an MSPrime/tskit .trees file."
        )
    )

    parser.add_argument(
        "trees",
        help="Path to the MSPrime .trees file"
    )

    parser.add_argument(
        "--outprefix",
        required=True,
        help=(
            "Output prefix. Files will be written as "
            "{outprefix}_coal_dist.csv and "
            "{outprefix}_branch_length_dist.csv"
        )
    )

    args = parser.parse_args()

    if not os.path.isfile(args.trees):
        print(f"ERROR: File does not exist: {args.trees}")
        sys.exit(1)

    process_trees(
        trees_path=args.trees,
        outprefix=args.outprefix
    )


if __name__ == "__main__":
    main()