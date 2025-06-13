## Advanced Configuration

### Custom Sources
Override default proxy sources:
```python
fetcher = ProxyFetcher()
fetcher.sources = [
    "https://your-custom-source.com/api",
    "http://local-proxy-list.txt"
]