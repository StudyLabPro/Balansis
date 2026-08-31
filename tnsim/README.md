# TNSIM - Theory of Zero-Sum Infinite Sets

[![Python](https://img.shields.io/badge/python-3.8+-blue.svg)](https://www.python.org/downloads/)
[![FastAPI](https://img.shields.io/badge/FastAPI-0.104+-green.svg)](https://fastapi.tiangolo.com/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-13+-blue.svg)](https://www.postgresql.org/)
[![License](https://img.shields.io/badge/license-AGPL--3.0%20%2F%20Commercial-blue.svg)](../LICENSING.md)

**TNSIM** (Theory of Zero-Sum Infinite Sets) is an innovative library for working with zero-sum sets and high-precision computations with rounding error compensation.

## 🚀 Key Features

- **High-precision computations**: Rounding error compensation algorithms
- **Zero-sum sets**: Working with infinite sets
- **Convergence analysis**: Tools for analyzing series convergence
- **Balansis integration**: Extended compensation capabilities
- **Zero-Sum Attention**: Attention mechanism for neural networks
- **REST API**: FastAPI interface for web integration
- **Parallel computing**: Multi-threaded processing
- **Caching**: Performance optimization

## 📦 Installation

### Requirements

- Python 3.8+
- PostgreSQL 13+
- Docker (optional)

### Installation from source

```bash
git clone https://github.com/StudyLabPro/Balansis.git
cd Balansis
pip install -e .
```

### Installation with Docker

```bash
docker-compose up -d
```

## 🏗️ Architecture

```
tnsim/
├── core/                    # Core components
│   ├── zero_sum_set.py     # ZeroSumInfiniteSet class
│   ├── cache.py            # Caching system
│   └── parallel.py         # Parallel computing
├── api/                     # FastAPI application
│   ├── main.py             # Main application
│   ├── routes/             # API routes
│   └── models/             # Pydantic models
├── integrations/           # Integrations
│   └── balansis_integration.py
├── database/               # Database
│   ├── models.py           # SQLAlchemy models
│   └── connection.py       # Database connection
├── tests/                  # Tests
├── examples/               # Usage examples
├── notebooks/              # Jupyter notebooks
└── docs/                   # Documentation
```

## 🔧 Quick Start

### Basic usage

```python
from tnsim.core.zero_sum_set import ZeroSumInfiniteSet

# Create zero-sum set
elements = [1.0, -0.5, -0.3, -0.2]
zero_sum_set = ZeroSumInfiniteSet(elements)

# Validate
validation = zero_sum_set.validate_zero_sum()
print(f"Valid: {validation['is_valid']}")

# Compensated summation
result = zero_sum_set.zero_sum_operation(method='compensated')
print(f"Result: {result}")
```

### Convergence analysis

```python
# Create harmonic series
harmonic_elements = [1/i for i in range(1, 1001)]
harmonic_elements.append(-sum(harmonic_elements))

harmonic_set = ZeroSumInfiniteSet(harmonic_elements, series_type='harmonic')

# Convergence analysis
convergence = harmonic_set.convergence_analysis()
print(f"Converges: {convergence['converges']}")
print(f"Type: {convergence['convergence_type']}")
```

### Balansis integration

```python
from tnsim.integrations.balansis_integration import BalansisCompensator

# Create compensator
compensator = BalansisCompensator(precision='high')

# Compensate series
series = [0.1, 0.01, 0.001] * 100
result, metrics = compensator.compensate_series(series)

print(f"Result: {result}")
print(f"Quality: {metrics.quality_score}")
```

### Zero-Sum Attention

```python
from tnsim.integrations.balansis_integration import ZeroSumAttention
import numpy as np

# Create attention model
attention = ZeroSumAttention(
    d_model=64,
    n_heads=8,
    compensation_strength=0.1
)

# Forward pass
x = np.random.randn(4, 32, 64).astype(np.float32)
output, attention_weights = attention.forward(x)

print(f"Output: {output.shape}")
print(f"Attention weights: {attention_weights.shape}")
```

## 🌐 REST API

### Start server

```bash
cd /path/to/Balansis
uvicorn tnsim.api.main:app --reload --host 0.0.0.0 --port 8000
```

### Main endpoints

#### Create zero-sum set

```bash
curl -X POST "http://localhost:8000/api/zerosum/create" \
     -H "Content-Type: application/json" \
     -d '{
       "elements": [1.0, -0.5, -0.3, -0.2],
       "series_type": "custom"
     }'
```

#### Zero-sum operation

```bash
curl -X POST "http://localhost:8000/api/zerosum/operation" \
     -H "Content-Type: application/json" \
     -d '{
       "set_id": "uuid-here",
       "method": "compensated"
     }'
```

#### Convergence analysis

```bash
curl -X POST "http://localhost:8000/api/zerosum/convergence" \
     -H "Content-Type: application/json" \
     -d '{
       "set_id": "uuid-here"
     }'
```

## 🗄️ Database

### PostgreSQL setup

```sql
-- Create database
CREATE DATABASE tnsim_db;

-- Connect to database
\c tnsim_db;

-- Create tables (executed automatically on startup)
```

### Environment variables

```bash
# .env file
DATABASE_URL=postgresql://username:password@localhost:5432/tnsim_db
REDIS_URL=redis://localhost:6379/0
SECRET_KEY=your-secret-key
DEBUG=True
```

## 🧪 Testing

### Run all tests

```bash
pytest tests/ -v
```

### Run specific tests

```bash
# Core component tests
pytest tests/test_zero_sum_set.py -v

# API tests
pytest tests/test_api.py -v

# Integration tests
pytest tests/test_balansis_integration.py -v
```

### Code coverage

```bash
pytest --cov=tnsim tests/
```

## 📊 Examples and Demonstrations

### Jupyter Notebooks

- `notebooks/zero_sum_theory_demo.ipynb` - Complete theory demonstration
- `notebooks/performance_analysis.ipynb` - Performance analysis
- `notebooks/financial_applications.ipynb` - Financial applications

### Code examples

- `examples/basic_usage.py` - Basic usage
- `examples/advanced_compensation.py` - Advanced compensation
- `examples/parallel_processing.py` - Parallel processing
- `examples/web_integration.py` - Web integration

## 🔬 Compensation Algorithms

### Available methods

1. **Direct** - Direct summation
2. **Compensated** - Kahan algorithm
3. **Iterative** - Iterative compensation
4. **Adaptive** - Adaptive compensation
5. **Stabilized** - Stabilized summation

### Performance comparison

| Method | Accuracy | Speed | Memory |
|--------|----------|-------|--------|
| Direct | ⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| Compensated | ⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐ |
| Iterative | ⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐ |
| Adaptive | ⭐⭐⭐⭐⭐ | ⭐⭐ | ⭐⭐ |
| Stabilized | ⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐ |

## 🚀 Performance

### Benchmarks

```python
# Performance testing
from tnsim.benchmarks import run_performance_test

results = run_performance_test(
    sizes=[1000, 10000, 100000],
    methods=['direct', 'compensated', 'adaptive']
)

print(results.summary())
```

### Optimization

- Use caching for repetitive computations
- Apply parallel processing for large sets
- Choose appropriate compensation method for your task

## 🔧 Configuration

### Cache settings

```python
from tnsim.core.cache import TNSIMCache

# Cache configuration
cache = TNSIMCache(
    max_size=1000,
    ttl=3600,  # 1 hour
    strategy='lru'
)
```

### Parallel processing

```python
from tnsim.core.parallel import ParallelTNSIM

# Parallel processing configuration
parallel_processor = ParallelTNSIM(
    num_workers=4,
    chunk_size=1000
)
```

## 🤝 Contributing

### How to contribute

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Code standards

- Follow PEP 8
- Add docstrings for all functions
- Cover code with tests
- Update documentation

## 📚 Documentation

### Complete documentation

- [API Reference](docs/api_reference.md)
- [Theoretical foundations](docs/theory.md)
- [Usage examples](docs/examples.md)
- [FAQ](docs/faq.md)

### Scientific papers

- "Theory of Zero-Sum Infinite Sets: Mathematical Foundations"
- "Compensation Algorithms for High-Precision Computing"
- "Zero-Sum Attention Mechanisms in Neural Networks"

## 🐛 Known Issues

- Performance may degrade for very large sets (>10^6 elements)
- Some compensation methods require additional memory
- Integration with some NumPy versions may cause warnings

## 🔮 Roadmap

### Version 2.0

- [ ] Complex number support
- [ ] GPU acceleration with CUDA
- [ ] Quantum compensation algorithms
- [ ] Extended TensorFlow/PyTorch integration

### Version 2.1

- [ ] Automatic parameter optimization
- [ ] Web interface for visualization
- [ ] Distributed computing support
- [ ] Cloud platform integration

## 📄 License

`tnsim` is distributed as part of the Balansis repository and follows the same
dual-licensing model:

- open-source use under [AGPL-3.0](../LICENSE)
- proprietary commercial use under [COMMERCIAL_LICENSE.md](../COMMERCIAL_LICENSE.md)
- routing guidance in [LICENSING.md](../LICENSING.md)

## 👥 Authors

- **Lead Developer** - [Your Name](https://github.com/yourusername)
- **Mathematical Consultant** - [Consultant Name](https://github.com/consultant)

## 🙏 Acknowledgments

- Balansis team for inspiration and support
- NumPy community for excellent tools
- All project contributors

## 📞 Support

- **Commercial / repository contact**: `andrew@xteam.pro`
- **Issues**: use the main Balansis repository issue tracker
- **Licensing**: see `../LICENSING.md` and `../COMMERCIAL_LICENSE.md`
- **Security**: report privately according to `../SECURITY.md`

---

**TNSIM** - Precision in every calculation! 🎯
