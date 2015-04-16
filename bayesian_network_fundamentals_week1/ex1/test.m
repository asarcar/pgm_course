% FACTORS.INPUT(1) contains P(X_1)
FACTORS.INPUT(1) = struct('var', [1], 'card', [2], 'val', [0.11, 0.89]);

% FACTORS.INPUT(2) contains P(X_2 | X_1)
FACTORS.INPUT(2) = struct('var', [2, 1], 'card', [2, 2], 'val', [0.59, 0.41, 0.22, 0.78]);

% FACTORS.INPUT(3) contains P(X_3 | X_2)
FACTORS.INPUT(3) = struct('var', [3, 2], 'card', [2, 2], 'val', [0.39, 0.61, 0.06, 0.94]);

% Factor Product
ProductRes = FactorProduct(FACTORS.INPUT(1), FACTORS.INPUT(2));
FACTORS.PRODUCT = struct('var', [1, 2], 'card', [2, 2], 'val', [0.0649, 0.1958, 0.0451, 0.6942]);
assert(norm(ProductRes.val - FACTORS.PRODUCT.val) < 0.00000001, 'Product Test: Failed');

% Factor Marginalization
MarginalizationRes = FactorMarginalization(FACTORS.INPUT(2), [2]);
FACTORS.MARGINALIZATION = struct('var', [1], 'card', [2], 'val', [1 1]); 
assert(norm(MarginalizationRes.val - FACTORS.MARGINALIZATION.val) < 0.00000001, 'Marginalization Test: Failed');

% Factor Evidence
EvidenceRes = ObserveEvidence(FACTORS.INPUT, [2 1; 3 2]);
FACTORS.EVIDENCE(1) = struct('var', [1], 'card', [2], 'val', [0.11, 0.89]);
FACTORS.EVIDENCE(2) = struct('var', [2, 1], 'card', [2, 2], 'val', [0.59, 0, 0.22, 0]);
FACTORS.EVIDENCE(3) = struct('var', [3, 2], 'card', [2, 2], 'val', [0, 0.61, 0, 0]);
for i=1:3,
  assert(norm(EvidenceRes(i).val - FACTORS.EVIDENCE(i).val) < 0.00000001, 'Evidence Test: Failed');
end;

% Compute Joint Distribution
JointRes = ComputeJointDistribution(FACTORS.INPUT);
FACTORS.JOINT = struct('var', [1, 2, 3], 'card', [2, 2, 2], 'val', [0.025311, 0.076362, 0.002706, 0.041652, 0.039589, 0.119438, 0.042394, 0.652548]);
assert(norm(JointRes.val - FACTORS.JOINT.val) < 0.00000001, 'Joint Test: Failed');

% Compute Marginal
% X_1:     [0.11, 0.89]
% X_2|X_1: [0.59, 0.41, 0.22, 0.78]
% X_3|X_2: [0.39, 0.61, 0.06, 0.94]
MarginalRes = ComputeMarginal([2, 3], FACTORS.INPUT, [1, 2]);
% Compute marginal cost where 1 is marginalized (as evidenced with value '2')
FACTORS.MARGINAL = struct('var', [2, 3], 'card', [2, 2], 'val', [0.0858, 0.0468, 0.1342, 0.7332]);
assert(norm(MarginalRes.val - FACTORS.MARGINAL.val) < 0.00000001, 'Compute Marginal Test: Failed');
