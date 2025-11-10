# Internal World Model Representation: DesignTimeDbContextFactory

## The Challenge

How does an agent internally represent a code snippet it intends to generate? Not as abstract syntax trees (ASTs) or token streams, but as a bitmap + role map + a big vector of [bitmap_value, position, purpose, lexical_token] tuples + a reuse map.

## Example: DesignTimeDbContextFactory for Entity Framework

### The Target Code (What We Want to Generate)

```csharp
public class DesignTimeDbContextFactory : IDesignTimeDbContextFactory<ApplicationDbContext>
{
    public ApplicationDbContext CreateDbContext(string[] args)
    {
        var optionsBuilder = new DbContextOptionsBuilder<ApplicationDbContext>();
        optionsBuilder.UseSqlServer("Server=.;Database=MyApp;Trusted_Connection=true;");
        return new ApplicationDbContext(optionsBuilder.Options);
    }
}
```

### The Internal Representation

```json
{
  "entity_id": "DesignTimeDbContextFactory_V1",
  "semantic_label": "dotnet_ef_factory_class",
  
  "bitmap_8x16_embedding_grid": {
    "description": "8 rows × 16 columns bitmap where EACH PIXEL is a learned embedding vector (not a scalar intensity). Each vector encodes the semantic identity and learned features of the code element at that spatial location.",
    "pixel_embedding_dimension": 16,
    "critical_note": "These are NOT intensities or probabilities. They are learned embeddings representing the semantic/syntactic identity of code tokens and structural elements. They encode what the element IS, not how bright it is.",
    "grid": [
      [
        [0.12, -0.34, 0.89, 0.21, -0.67, 0.45, -0.23, 0.78, 0.01, -0.56, 0.34, -0.12, 0.67, -0.45, 0.23, 0.89],
        [0.34, 0.12, -0.56, 0.89, 0.23, -0.78, 0.45, 0.01, -0.34, 0.67, -0.12, 0.56, 0.89, -0.23, 0.45, -0.67],
        [0.56, 0.78, -0.23, 0.34, -0.89, 0.12, 0.67, -0.45, 0.23, 0.01, -0.34, 0.89, -0.56, 0.12, 0.45, 0.23],
        [0.01, -0.45, 0.67, -0.78, 0.34, 0.23, -0.56, 0.89, 0.12, -0.34, 0.45, 0.67, -0.01, 0.78, -0.23, 0.56]
      ],
      [
        [0.23, 0.56, -0.34, 0.89, 0.12, -0.67, 0.45, -0.23, 0.78, 0.01, -0.56, 0.34, -0.12, 0.67, -0.45, 0.23],
        [0.45, -0.12, 0.78, 0.01, -0.34, 0.67, -0.12, 0.56, 0.89, -0.23, 0.45, -0.67, 0.34, 0.12, -0.56, 0.89],
        [0.67, -0.45, 0.23, 0.01, -0.34, 0.89, -0.56, 0.12, 0.45, 0.23, 0.56, 0.78, -0.23, 0.34, -0.89, 0.12],
        [0.78, 0.01, -0.56, 0.34, -0.12, 0.67, -0.45, 0.23, 0.01, -0.45, 0.67, -0.78, 0.34, 0.23, -0.56, 0.89]
      ],
      [
        [0.34, 0.89, -0.23, 0.56, 0.12, -0.67, 0.78, -0.45, 0.01, 0.34, -0.12, 0.56, 0.89, -0.23, 0.45, -0.67],
        [0.12, -0.78, 0.45, 0.23, -0.56, 0.89, 0.01, -0.34, 0.67, -0.12, 0.56, 0.89, -0.23, 0.45, -0.67, 0.34],
        [0.89, -0.12, 0.34, -0.56, 0.78, 0.01, -0.45, 0.67, -0.78, 0.34, 0.23, -0.56, 0.89, 0.12, -0.67, 0.45],
        [0.56, 0.23, -0.34, 0.01, 0.67, -0.45, 0.23, 0.89, -0.56, 0.12, 0.45, 0.23, 0.56, 0.78, -0.23, 0.34]
      ],
      [
        [0.01, 0.45, -0.67, 0.89, -0.34, 0.12, 0.56, -0.78, 0.23, 0.01, -0.45, 0.67, -0.78, 0.34, 0.23, -0.56],
        [0.78, -0.23, 0.45, 0.12, -0.67, 0.34, 0.89, 0.56, -0.12, 0.78, 0.01, -0.34, 0.67, -0.12, 0.56, 0.89],
        [0.34, 0.67, -0.45, 0.23, 0.01, -0.34, 0.89, -0.56, 0.12, 0.45, 0.23, 0.56, 0.78, -0.23, 0.34, -0.89],
        [0.56, 0.01, -0.78, 0.23, 0.45, -0.12, 0.67, 0.34, -0.56, 0.89, -0.23, 0.45, -0.67, 0.34, 0.12, -0.56]
      ],
      [
        [0.89, -0.34, 0.12, 0.56, -0.78, 0.23, 0.01, -0.45, 0.67, -0.78, 0.34, 0.23, -0.56, 0.89, 0.12, -0.67],
        [0.45, 0.23, -0.56, 0.89, 0.01, -0.34, 0.78, -0.12, 0.45, 0.67, -0.23, 0.56, 0.12, 0.78, -0.34, 0.89],
        [0.12, -0.67, 0.34, 0.89, -0.23, 0.56, 0.01, -0.45, 0.67, -0.12, 0.56, 0.89, -0.23, 0.45, -0.67, 0.34],
        [0.78, 0.45, -0.12, 0.23, 0.56, -0.34, 0.89, 0.01, -0.56, 0.34, -0.12, 0.67, -0.45, 0.23, 0.01, -0.34]
      ],
      [
        [0.01, 0.78, -0.56, 0.34, 0.23, -0.34, 0.89, -0.56, 0.12, 0.45, 0.23, 0.56, 0.78, -0.23, 0.34, -0.89],
        [0.67, -0.45, 0.23, 0.01, -0.78, 0.45, 0.23, -0.56, 0.89, 0.12, -0.67, 0.34, 0.89, -0.23, 0.56, 0.12],
        [0.34, 0.12, -0.67, 0.45, 0.56, -0.34, 0.89, 0.01, -0.56, 0.34, -0.12, 0.67, -0.45, 0.23, 0.01, -0.45],
        [0.89, 0.56, -0.12, 0.78, 0.01, -0.34, 0.67, 0.23, -0.56, 0.89, -0.23, 0.45, -0.67, 0.34, 0.12, -0.56]
      ],
      [
        [0.23, -0.34, 0.78, 0.56, -0.78, 0.23, 0.01, -0.45, 0.67, -0.12, 0.56, 0.89, -0.23, 0.45, -0.67, 0.34],
        [0.45, 0.01, -0.56, 0.34, 0.89, -0.12, 0.67, -0.45, 0.23, 0.01, -0.34, 0.89, -0.56, 0.12, 0.45, 0.23],
        [0.12, 0.67, -0.34, 0.89, -0.23, 0.56, 0.01, -0.45, 0.67, -0.78, 0.34, 0.23, -0.56, 0.89, 0.12, -0.67],
        [0.78, 0.45, -0.12, 0.23, 0.56, -0.34, 0.89, 0.01, -0.56, 0.34, -0.12, 0.67, -0.45, 0.23, 0.01, -0.34]
      ],
      [
        [0.34, 0.89, -0.23, 0.56, 0.12, -0.67, 0.78, -0.45, 0.01, 0.34, -0.12, 0.56, 0.89, -0.23, 0.45, -0.67],
        [0.56, -0.34, 0.01, 0.78, -0.12, 0.45, 0.67, -0.23, 0.56, 0.89, -0.34, 0.12, 0.56, -0.78, 0.23, 0.01],
        [0.01, 0.23, -0.56, 0.34, 0.89, -0.12, 0.67, -0.45, 0.23, 0.01, -0.34, 0.89, -0.56, 0.12, 0.45, 0.23],
        [0.12, 0.67, -0.34, 0.89, -0.23, 0.56, 0.01, -0.45, 0.67, -0.12, 0.56, 0.89, -0.23, 0.45, -0.67, 0.34]
      ]
    ]
  },
  
  "role_purpose_map": {
    "description": "Flat list of all purposes/roles used in this code block",
    "roles": [
      "accessibility_modifier",
      "class_keyword",
      "class_name",
      "inheritance_colon",
      "interface_name",
      "generic_open",
      "context_type_placeholder",
      "generic_close",
      "method_visibility",
      "method_return_type",
      "method_name",
      "method_params_open",
      "param_type",
      "param_name",
      "method_params_close",
      "method_body_open",
      "var_keyword",
      "var_name",
      "assignment",
      "new_keyword",
      "constructor_type",
      "method_invocation_chain",
      "return_keyword",
      "context_type_constructor",
      "method_call_open",
      "method_argument",
      "method_call_close",
      "code_block_close",
      "indentation",
      "semicolon"
    ]
  },
  
  "big_vector_feedforward_layer": {
    "description": "Feedforward layer marrying bitmap embeddings to role purposes and lexical tokens. Each entry indexes into the embedding_grid via [row, col], looks up the embedding vector, and fuses it with position, role, and lexical token.",
    "schema": "[bitmap_index: [row, col], position_float, purpose_role_index, lexical_token]",
    "entries": [
      [[0, 0], 0.0, 0, "public"],
      [[0, 1], 0.3, 1, "class"],
      [[0, 2], 0.6, 2, "DesignTimeDbContextFactory"],
      [[0, 3], 1.0, 3, ":"],
      [[1, 0], 1.3, 4, "IDesignTimeDbContextFactory"],
      [[1, 1], 1.6, 5, "<"],
      [[1, 2], 1.8, 6, "APPLICATION_DBCONTEXT_NAME"],
      [[1, 3], 2.0, 7, ">"],
      [[2, 0], 2.5, 8, "public"],
      [[2, 1], 2.8, 9, "APPLICATION_DBCONTEXT_NAME"],
      [[2, 2], 3.1, 10, "CreateDbContext"],
      [[2, 3], 3.4, 11, "("],
      [[3, 0], 3.6, 12, "string[]"],
      [[3, 1], 3.9, 13, "args"],
      [[3, 2], 4.1, 14, ")"],
      [[3, 3], 4.5, 15, "{"],
      [[4, 0], 5.0, 16, "var"],
      [[4, 1], 5.2, 17, "optionsBuilder"],
      [[4, 2], 5.5, 18, "="],
      [[4, 3], 5.7, 19, "new"],
      [[5, 0], 5.9, 20, "DbContextOptionsBuilder"],
      [[5, 1], 6.2, 5, "<"],
      [[5, 2], 6.4, 6, "APPLICATION_DBCONTEXT_NAME"],
      [[5, 3], 6.6, 7, ">"],
      [[6, 0], 6.8, 21, "optionsBuilder.UseSqlServer(...)"],
      [[6, 1], 7.0, 22, "return"],
      [[6, 2], 7.3, 19, "new"],
      [[6, 3], 7.5, 23, "APPLICATION_DBCONTEXT_NAME"],
      [[7, 0], 7.8, 24, "("],
      [[7, 1], 8.0, 25, "optionsBuilder.Options"],
      [[7, 2], 8.2, 26, ")"]
    ]
  },
  
  "name_reuse_map": {
    "APPLICATION_DBCONTEXT_NAME": {
      "description": "The DbContext type (e.g., ApplicationDbContext)",
      "occurrences": [
        {
          "vector_index": 6,
          "position": 1.8,
          "context": "IDesignTimeDbContextFactory<APPLICATION_DBCONTEXT_NAME>"
        },
        {
          "vector_index": 9,
          "position": 2.8,
          "context": "public APPLICATION_DBCONTEXT_NAME CreateDbContext(...)"
        },
        {
          "vector_index": 22,
          "position": 6.4,
          "context": "new DbContextOptionsBuilder<APPLICATION_DBCONTEXT_NAME>()"
        },
        {
          "vector_index": 27,
          "position": 7.5,
          "context": "return new APPLICATION_DBCONTEXT_NAME(...)"
        }
      ],
      "binding_status": "unbound",
      "confidence": 0.0,
      "required_instrument": "DbContextType"
    },
    "optionsBuilder": {
      "description": "The DbContextOptionsBuilder variable",
      "occurrences": [
        {
          "vector_index": 17,
          "position": 5.2,
          "context": "var optionsBuilder = ..."
        },
        {
          "vector_index": 24,
          "position": 6.8,
          "context": "optionsBuilder.UseSqlServer(...)"
        },
        {
          "vector_index": 29,
          "position": 8.0,
          "context": "return new ApplicationDbContext(optionsBuilder.Options)"
        }
      ],
      "binding_status": "bound_locally",
      "confidence": 1.0
    }
  }
}
```

### Structure Explained

This is just one big verbose and excessively mathematical way of expressing the concept of "access modifier goes top left", "class name goes after class keyword", etc. But it is precise and machine-interpretable.

### How Binding Works

When `DbContextType` (a RequiredInstrument) is resolved to `"ApplicationDbContext"`:
- The name_reuse_map for `APPLICATION_DBCONTEXT_NAME` is updated: binding_status → "bound", binding_value → "ApplicationDbContext"
- All 4 vector entries (indices 6, 9, 22, 27) are updated simultaneously
- Lexical tokens in those positions are resolved: `"APPLICATION_DBCONTEXT_NAME"` → `"ApplicationDbContext"`