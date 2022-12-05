{ ... }:

{
  imports = [
    <home-manager/nixos>
    ./kde-configs.nix
  ];

  home-manager.users.adityag = { config, ... }: {
    xdg.configFile."vlc/vlcrc".text = ''
      [core]
      random=1
      metadata-network-access=1
      key-rate-normal=s
      key-rate-faster-fine=d
      key-rate-slower-fine=a
    '';
    #home.file.".config/"

    home.file.".clang-format".text = ''
      ---
      Language:        Cpp
      # BasedOnStyle:  LLVM
      AccessModifierOffset: -2
      AlignAfterOpenBracket: Align
      AlignConsecutiveMacros: None
      AlignConsecutiveAssignments: None
      AlignConsecutiveBitFields: None
      AlignConsecutiveDeclarations: None
      AlignEscapedNewlines: Right
      AlignOperands:   Align
      AlignTrailingComments: true
      AllowAllArgumentsOnNextLine: true
      AllowAllConstructorInitializersOnNextLine: true
      AllowAllParametersOfDeclarationOnNextLine: true
      AllowShortEnumsOnASingleLine: true
      AllowShortBlocksOnASingleLine: Never
      AllowShortCaseLabelsOnASingleLine: false
      AllowShortFunctionsOnASingleLine: Inline
      AllowShortLambdasOnASingleLine: All
      AllowShortIfStatementsOnASingleLine: Never
      AllowShortLoopsOnASingleLine: false
      AlwaysBreakAfterDefinitionReturnType: None
      AlwaysBreakAfterReturnType: None
      AlwaysBreakBeforeMultilineStrings: false
      AlwaysBreakTemplateDeclarations: MultiLine
      AttributeMacros:
        - __capability
      BinPackArguments: true
      BinPackParameters: true
      BraceWrapping:
        AfterCaseLabel:  false
        AfterClass:      false
        AfterControlStatement: Never
        AfterEnum:       false
        AfterFunction:   false
        AfterNamespace:  false
        AfterObjCDeclaration: false
        AfterStruct:     false
        AfterUnion:      false
        AfterExternBlock: false
        BeforeCatch:     false
        BeforeElse:      false
        BeforeLambdaBody: false
        BeforeWhile:     false
        IndentBraces:    false
        SplitEmptyFunction: true
        SplitEmptyRecord: true
        SplitEmptyNamespace: true
      BreakBeforeBinaryOperators: None
      BreakBeforeConceptDeclarations: true
      BreakBeforeBraces: Attach
      BreakBeforeInheritanceComma: false
      BreakInheritanceList: BeforeColon
      BreakBeforeTernaryOperators: true
      BreakConstructorInitializersBeforeComma: false
      BreakConstructorInitializers: BeforeColon
      BreakAfterJavaFieldAnnotations: false
      BreakStringLiterals: true
      ColumnLimit:     80
      CommentPragmas:  '^ IWYU pragma:'
      CompactNamespaces: false
      ConstructorInitializerAllOnOneLineOrOnePerLine: false
      ConstructorInitializerIndentWidth: 4
      ContinuationIndentWidth: 4
      Cpp11BracedListStyle: true
      DeriveLineEnding: true
      DerivePointerAlignment: false
      DisableFormat:   false
      EmptyLineBeforeAccessModifier: LogicalBlock
      ExperimentalAutoDetectBinPacking: false
      FixNamespaceComments: true
      ForEachMacros:
        - foreach
        - Q_FOREACH
        - BOOST_FOREACH
      StatementAttributeLikeMacros:
        - Q_EMIT
      IncludeBlocks:   Preserve
      IncludeCategories:
        - Regex:           '^"(llvm|llvm-c|clang|clang-c)/'
          Priority:        2
          SortPriority:    0
          CaseSensitive:   false
        - Regex:           '^(<|"(gtest|gmock|isl|json)/)'
          Priority:        3
          SortPriority:    0
          CaseSensitive:   false
        - Regex:           '.*'
          Priority:        1
          SortPriority:    0
          CaseSensitive:   false
      IncludeIsMainRegex: '(Test)?$'
      IncludeIsMainSourceRegex: ""
      IndentCaseLabels: false
      IndentCaseBlocks: false
      IndentGotoLabels: true
      IndentPPDirectives: None
      IndentExternBlock: AfterExternBlock
      IndentRequires:  false
      IndentWidth:     4
      IndentWrappedFunctionNames: false
      InsertTrailingCommas: None
      JavaScriptQuotes: Leave
      JavaScriptWrapImports: true
      KeepEmptyLinesAtTheStartOfBlocks: true
      MacroBlockBegin: ""
      MacroBlockEnd:   ""
      MaxEmptyLinesToKeep: 1
      NamespaceIndentation: None
      ObjCBinPackProtocolList: Auto
      ObjCBlockIndentWidth: 4
      ObjCBreakBeforeNestedBlockParam: true
      ObjCSpaceAfterProperty: false
      ObjCSpaceBeforeProtocolList: true
      PenaltyBreakAssignment: 2
      PenaltyBreakBeforeFirstCallParameter: 19
      PenaltyBreakComment: 300
      PenaltyBreakFirstLessLess: 120
      PenaltyBreakString: 1000
      PenaltyBreakTemplateDeclaration: 10
      PenaltyExcessCharacter: 1000000
      PenaltyReturnTypeOnItsOwnLine: 60
      PenaltyIndentedWhitespace: 0
      PointerAlignment: Right
      ReflowComments:  true
      SortIncludes:    true
      SortJavaStaticImport: Before
      SortUsingDeclarations: true
      SpaceAfterCStyleCast: false
      SpaceAfterLogicalNot: false
      SpaceAfterTemplateKeyword: true
      SpaceBeforeAssignmentOperators: true
      SpaceBeforeCaseColon: false
      SpaceBeforeCpp11BracedList: false
      SpaceBeforeCtorInitializerColon: true
      SpaceBeforeInheritanceColon: true
      SpaceBeforeParens: ControlStatements
      SpaceAroundPointerQualifiers: Default
      SpaceBeforeRangeBasedForLoopColon: true
      SpaceInEmptyBlock: false
      SpaceInEmptyParentheses: false
      SpacesBeforeTrailingComments: 1
      SpacesInAngles:  false
      SpacesInConditionalStatement: false
      SpacesInContainerLiterals: true
      SpacesInCStyleCastParentheses: false
      SpacesInParentheses: false
      SpacesInSquareBrackets: false
      SpaceBeforeSquareBrackets: false
      BitFieldColonSpacing: Both
      Standard:        Latest
      StatementMacros:
        - Q_UNUSED
        - QT_REQUIRE_VERSION
      TabWidth:        8
      UseCRLF:         false
      UseTab:          Never
      WhitespaceSensitiveMacros:
        - STRINGIZE
        - PP_STRINGIZE
        - BOOST_PP_STRINGIZE
        - NS_SWIFT_NAME
        - CF_SWIFT_NAME
      ...
    '';

    home.file.".duplicacy/preferences".text = ''
      [
        {
          "name": "default",
          "id": "arch-home-backup",
          "repository": "",
          "storage": "/run/media/adityag/Partition_2/duplicacy-linux-backup",
          "encrypted": false,
          "no_backup": false,
          "no_restore": false,
          "no_save_password": false,
          "nobackup_file": "",
          "keys": null,
          "filters": "",
          "exclude_by_attribute": false
        },
        {
            "name": "arch-home-backup",
            "id": "arch-home-backup",
            "repository": "",
            "storage": "/run/media/adityag/Partition_2/duplicacy-linux-backup",
            "encrypted": false,
            "no_backup": false,
            "no_restore": false,
            "no_save_password": false,
            "nobackup_file": "",
            "keys": null,
            "filters": "",
            "exclude_by_attribute": false
        }
      ]
    '';
  };
}            

# ex: shiftwidth=2 expandtab: 
