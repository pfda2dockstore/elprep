baseCommand: []
class: CommandLineTool
cwlVersion: v1.0
id: elprep
inputs:
  clean_sam:
    default: false
    doc: 'This filter fixes alignments: it soft-clips alignments that hang off the
      end of its reference sequence, and sets the mapping quality to 0 if the alignment
      is unmapped.'
    inputBinding:
      position: 5
      prefix: --clean_sam
    type: boolean
  filter_unmapped_reads:
    default: false
    doc: This filter removes all alignments in the input file that are unmapped. An
      alignment is determined unmapped when bit 0x4 of its FLAG is set.
    inputBinding:
      position: 6
      prefix: --filter_unmapped_reads
    type: boolean
  filter_unmapped_reads_strict:
    default: false
    doc: This filter removes all alignments in the input file that are unmapped. An
      alignment is determined unmapped when bit 0x4 of its FLAG is set, or where the
      mapping position (POS) is 0, or where the reference sequence name (RNAME) is
      *.
    inputBinding:
      position: 7
      prefix: --filter_unmapped_reads_strict
    type: boolean
  gc_level:
    default: 0
    doc: 'This option configures garbage collection during the elPrep execution. Possible
      values: 0, 1, 2.'
    inputBinding:
      position: 15
      prefix: --gc_level
    type: long
  input:
    doc: The input file. Can be in sam, bam, or cram format.
    inputBinding:
      position: 1
      prefix: --input
    type: File
  intermediate_files_output_type:
    doc: 'The output type that will be used for intermediate split files in split/filter/merge
      mode. Possible values: sam (default), bam, cram.'
    inputBinding:
      position: 16
      prefix: --intermediate_files_output_type
    type: string?
  mark_duplicates:
    default: false
    doc: This filter identifies and marks the duplicate reads in the input file by
      setting bit 0x400 of their FLAG.
    inputBinding:
      position: 8
      prefix: --mark_duplicates
    type: boolean
  nr_of_threads:
    default: 1
    doc: This option sets the number of threads elPrep uses during execution.
    inputBinding:
      position: 3
      prefix: --nr_of_threads
    type: long
  output_name:
    doc: The name of the output file. Can be in sam, bam, or cram format.
    inputBinding:
      position: 2
      prefix: --output_name
    type: string
  reference_T:
    doc: A fasta format reference file used by SAMtools for .cram compression, optionally
      compressed with bgzip and indexed by samtools faidx. elPrep uses it to fill
      in the "-T" option when calling the samtools view command for converting to
      .cram.
    inputBinding:
      position: 13
      prefix: --reference_T
    type: File?
  reference_t:
    doc: A tab-delimited file, where a first column lists the reference names and
      a second column lists the lengths of those references; for example, a .fai file
      generated with samtools faidx. elPrep uses it to fill in the "-t" option when
      calling the samtools view command for converting to .cram.
    inputBinding:
      position: 14
      prefix: --reference_t
    type: File?
  remove_duplicates:
    default: false
    doc: This filter identifies and removes the duplicate reads.
    inputBinding:
      position: 9
      prefix: --remove_duplicates
    type: boolean
  replace_read_group:
    doc: This filter replaces or adds read groups to the alignments in the input file.
      The string passed here can be any string conforming to a header line for tag
      @RG, omitting the tag @RG itself, and using whitespace as separators for the
      line instead of TABs.
    inputBinding:
      position: 11
      prefix: --replace_read_group
    type: string?
  replace_reference_sequences:
    doc: This filter is used for replacing the header of a .sam/.bam/.cram file by
      a new header. The format of the new header can either be a .dict file, or another
      .sam/.bam/.cram file from which the new header is extracted.
    inputBinding:
      position: 10
      prefix: --replace_reference_sequences
    type: File?
  sfm:
    default: false
    doc: Option for splitting the input per chromosome, processing the smaller input
      files, and finally merging the partial results.
    inputBinding:
      position: 4
      prefix: --sfm
    type: boolean
  sorting_order:
    default: keep
    doc: 'This option determines the order of the alignments in the output file, performing
      a sort on the input if necessary. Possible values: keep, unknown, unsorted,
      queryname, coordinate.'
    inputBinding:
      position: 12
      prefix: --sorting_order
    type: string
label: elPrep
outputs:
  output:
    doc: The output file.
    outputBinding:
      glob: output/*
    type: File
requirements:
- class: DockerRequirement
  dockerOutputDirectory: /data/out
  dockerPull: pfda2dockstore/elprep:19
s:author:
  class: s:Person
  s:name: Pascal Costanza
