1. Create file with dN/dS rate ratios and uniprot IDs (filtering out overlapping haplotigs) 
SGE_Batch -c "python /nfs0/BB/Hendrix_Lab/Hops/GenomeAlignments/cdsFromAlignment/macseAnalysis/scripts/getGeneHits_filteredHaps.py ../dNdS_fileList.txt maskedDedupCascade_vs_uniprotMBH_len150.txt overlappingHaplotigs_maxThresh0.txt > dNdS_rateRatioWithUniProtIDs.txt" -r get_dNdS_withUniProtIDs_sge -q nucleotide

2. link hits to GO terms
python /nfs0/BB/Hendrix_Lab/Hops/GenomeAlignments/cdsFromAlignment/macseAnalysis/scripts/linkGenes2GO_v2.py dNdS_rateRatioWithUniProtIDs.txt uniprot_embryophyta_filtered_reviewedYes_goIDsOnly.tab > genesWithGOTerms_len150_filteredHaps.txt

3. GO term-focused file containing GO term, primary geneID, hap geneID, dnds, uniprotID
python /nfs0/BB/Hendrix_Lab/Hops/GenomeAlignments/cdsFromAlignment/macseAnalysis/scripts/identifyEnrichedGOTerms_v2.py genesWithGOTerms_len150_filteredHaps.txt > goTermCentricGeneList.txt

4. create GO category-specific files containing uniprotID, go term, go desc, go term count, primary geneId, hap geneID, dnds rate
python /nfs0/BB/Hendrix_Lab/Hops/GenomeAlignments/cdsFromAlignment/macseAnalysis/scripts/getGOCount.py uniprot-embryophyta-filtered-reviewedYes_biologicalProcesses.tab goTermCentricGeneList.txt > genesWithBiologicalProcessesGOTerms_withBestHitsFromMBH_len150_filteredHaps.txt
python /nfs0/BB/Hendrix_Lab/Hops/GenomeAlignments/cdsFromAlignment/macseAnalysis/scripts/getGOCount.py uniprot-embryophyta-filtered-reviewedYes_cellularComponent.tab goTermCentricGeneList.txt > genesWithCellularComponentsGOTerms_withBestHitsFromMBH_len150_filteredHaps.txt
python /nfs0/BB/Hendrix_Lab/Hops/GenomeAlignments/cdsFromAlignment/macseAnalysis/scripts/getGOCount.py uniprot-embryophyta-filtered-reviewedYes_molecularFunction.tab goTermCentricGeneList.txt > genesWithMolecularFunctionGOTerms_withBestHitsFromMBH_len150_filteredHaps.txt

5. Hypergeometric test
python /nfs0/BB/Hendrix_Lab/Hops/GenomeAlignments/cdsFromAlignment/macseAnalysis/uniprotHitAnalysis/hypergeometricAnalysis/scripts/hypergeometricTest.py genesWithBiologicalProcessesGOTerms_withBestHitsFromMBH_len150_filteredHaps.txt
python /nfs0/BB/Hendrix_Lab/Hops/GenomeAlignments/cdsFromAlignment/macseAnalysis/uniprotHitAnalysis/hypergeometricAnalysis/scripts/hypergeometricTest.py genesWithCellularComponentsGOTerms_withBestHitsFromMBH_len150_filteredHaps.txt
python /nfs0/BB/Hendrix_Lab/Hops/GenomeAlignments/cdsFromAlignment/macseAnalysis/uniprotHitAnalysis/hypergeometricAnalysis/scripts/hypergeometricTest.py genesWithMolecularFunctionGOTerms_withBestHitsFromMBH_len150_filteredHaps.txt