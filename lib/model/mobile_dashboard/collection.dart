class CollectionModel {
  final String branchName;
  final double portofolioAmount;
  final double portofolioCount;
  final double lastPortofolioAmount;
  final double lastPortofolioCount;
  final double portofolioAmountDiff;
  final double portofolioCountLastDiff;
  final double currentAmount;
  final double currentCount;
  final double currentPerc;
  final double lastCurrentAmount;
  final double lastCurrentCount;
  final double lastCurrentPerc;
  final double currentDiffAmount;
  final double currentDiffCount;
  final double currentDiffPerc;
  final double bucket1_30Amount;
  final double bucket1_30Count;
  final double bucket1_30Perc;
  final double lastBucket1_30Amount;
  final double lastBucket1_30Count;
  final double lastBucket1_30Perc;
  final double bucket1_30DiffAmount;
  final double bucket1_30DiffCount;
  final double bucket1_30DiffPerc;
  final double bucket31_60Amount;
  final double bucket31_60Count;
  final double bucket31_60Perc;
  final double lastBucket31_60Amount;
  final double lastBucket31_60Count;
  final double lastBucket31_60Perc;
  final double bucket31_60DiffAmount;
  final double bucket31_60DiffCount;
  final double bucket31_60DiffPerc;
  final double bucket61_90Amount;
  final double bucket61_90Count;
  final double bucket61_90Perc;
  final double lastBucket61_90Amount;
  final double lastBucket61_90Count;
  final double lastBucket61_90Perc;
  final double bucket61_90DiffAmount;
  final double bucket61_90DiffCount;
  final double bucket61_90DiffPerc;
  final double bucket91_120Amount;
  final double bucket91_120Count;
  final double bucket91_120Perc;
  final double lastBucket91_120Amount;
  final double lastBucket91_120Count;
  final double lastBucket91_120Perc;
  final double bucket91_120DiffAmount;
  final double bucket91_120DiffCount;
  final double bucket91_120DiffPerc;
  final double bucket121_150Amount;
  final double bucket121_150Count;
  final double bucket121_150Perc;
  final double lastBucket121_150Amount;
  final double lastBucket121_150Count;
  final double lastBucket121_150Perc;
  final double bucket121_150DiffAmount;
  final double bucket121_150DiffCount;
  final double bucket121_150DiffPerc;
  final double bucket151_180Amount;
  final double bucket151_180Count;
  final double bucket151_180Perc;
  final double lastBucket151_180Amount;
  final double lastBucket151_180Count;
  final double lastBucket151_180Perc;
  final double bucket151_180DiffAmount;
  final double bucket151_180DiffCount;
  final double bucket151_180DiffPerc;
  final double bucket181_270Amount;
  final double bucket181_270Count;
  final double bucket181_270Perc;
  final double lastBucket181_270Amount;
  final double lastBucket181_270Count;
  final double lastBucket181_270Perc;
  final double bucket181_270DiffAmount;
  final double bucket181_270DiffCount;
  final double bucket181_270DiffPerc;
  final double bucketUpTo270Amount;
  final double bucketUpTo270Count;
  final double bucketUpTo270Perc;
  final double lastBucketUpTo270Amount;
  final double lastBucketUpTo270Count;
  final double lastBucketUpTo270Perc;
  final double bucketUpTo270DiffAmount;
  final double bucketUpTo270DiffCount;
  final double bucketUpTo270DiffPerc;
  final double bucketWOAmount;
  final double bucketWOCount;
  final double bucketWOPerc;
  final double lastBucketWOAmount;
  final double lastBucketWOCount;
  final double lastBucketWOPerc;
  final double bucketWODiffAmount;
  final double bucketWODiffCount;
  final double bucketWODiffPerc;
  final double todLastBucketCount;
  final double todLastBucketAmount;
  final double todLastBucketPerc;
  final double todCount;
  final double todAmount;
  final double todPerc;
  final double todDiffCount;
  final double todDiffAmount;
  final double todDiffPerc;
  final double lastBucketPortofolioPerc;
  final double bucketPortofolioPerc;
  final double bucketPortofolioDiffPerc;
  final double bal30upLastBucketAmount;
  final double bal30upLastBucketCount;
  final double bal30upLastBucketPerc;
  final double bal30upBucketAmount;
  final double bal30upBucketCount;
  final double bal30upBucketPerc;
  final double bal30upBucketDiffAmount;
  final double bal30upBucketDiffCount;
  final double bal30upBucketDiffPerc;
  final double bal60upLastBucketAmount;
  final double bal60upLastBucketCount;
  final double bal60upLastBucketPerc;
  final double bal60upBucketAmount;
  final double bal60upBucketCount;
  final double bal60upBucketPerc;
  final double bal60upBucketDiffAmount;
  final double bal60upBucketDiffCount;
  final double bal60upBucketDiffPerc;
  final double npl90upLastBucketAmount;
  final double npl90upLastBucketCount;
  final double npl90upLastBucketPerc;
  final double npl90upBucketAmount;
  final double npl90upBucketCount;
  final double npl90upBucketPerc;
  final double npl90upBucketDiffAmount;
  final double npl90upBucketDiffCount;
  final double npl90upBucketDiffPerc;

  CollectionModel(
      {this.portofolioAmount,
        this.portofolioCount,
        this.lastPortofolioAmount,
        this.lastPortofolioCount,
        this.portofolioAmountDiff,
        this.portofolioCountLastDiff,
        this.currentAmount,
        this.currentCount,
        this.currentPerc,
        this.lastCurrentAmount,
        this.lastCurrentCount,
        this.lastCurrentPerc,
        this.currentDiffAmount,
        this.currentDiffCount,
        this.currentDiffPerc,
        this.bucket1_30Amount,
        this.bucket1_30Count,
        this.bucket1_30Perc,
        this.lastBucket1_30Amount,
        this.lastBucket1_30Count,
        this.lastBucket1_30Perc,
        this.bucket1_30DiffAmount,
        this.bucket1_30DiffCount,
        this.bucket1_30DiffPerc,
        this.bucket31_60Amount,
        this.bucket31_60Count,
        this.bucket31_60Perc,
        this.lastBucket31_60Amount,
        this.lastBucket31_60Count,
        this.lastBucket31_60Perc,
        this.bucket31_60DiffAmount,
        this.bucket31_60DiffCount,
        this.bucket31_60DiffPerc,
        this.bucket61_90Amount,
        this.bucket61_90Count,
        this.bucket61_90Perc,
        this.lastBucket61_90Amount,
        this.lastBucket61_90Count,
        this.lastBucket61_90Perc,
        this.bucket61_90DiffAmount,
        this.bucket61_90DiffCount,
        this.bucket61_90DiffPerc,
        this.bucket91_120Amount,
        this.bucket91_120Count,
        this.bucket91_120Perc,
        this.lastBucket91_120Amount,
        this.lastBucket91_120Count,
        this.lastBucket91_120Perc,
        this.bucket91_120DiffAmount,
        this.bucket91_120DiffCount,
        this.bucket91_120DiffPerc,
        this.bucket121_150Amount,
        this.bucket121_150Count,
        this.bucket121_150Perc,
        this.lastBucket121_150Amount,
        this.lastBucket121_150Count,
        this.lastBucket121_150Perc,
        this.bucket121_150DiffAmount,
        this.bucket121_150DiffCount,
        this.bucket121_150DiffPerc,
        this.bucket151_180Amount,
        this.bucket151_180Count,
        this.bucket151_180Perc,
        this.lastBucket151_180Amount,
        this.lastBucket151_180Count,
        this.lastBucket151_180Perc,
        this.bucket151_180DiffAmount,
        this.bucket151_180DiffCount,
        this.bucket151_180DiffPerc,
        this.bucket181_270Amount,
        this.bucket181_270Count,
        this.bucket181_270Perc,
        this.lastBucket181_270Amount,
        this.lastBucket181_270Count,
        this.lastBucket181_270Perc,
        this.bucket181_270DiffAmount,
        this.bucket181_270DiffCount,
        this.bucket181_270DiffPerc,
        this.bucketUpTo270Amount,
        this.bucketUpTo270Count,
        this.bucketUpTo270Perc,
        this.lastBucketUpTo270Amount,
        this.lastBucketUpTo270Count,
        this.lastBucketUpTo270Perc,
        this.bucketUpTo270DiffAmount,
        this.bucketUpTo270DiffCount,
        this.bucketUpTo270DiffPerc,
        this.bucketWOAmount,
        this.bucketWOCount,
        this.bucketWOPerc,
        this.lastBucketWOAmount,
        this.lastBucketWOCount,
        this.lastBucketWOPerc,
        this.bucketWODiffAmount,
        this.bucketWODiffCount,
        this.bucketWODiffPerc,
        this.todLastBucketCount,
        this.todLastBucketAmount,
        this.todLastBucketPerc,
        this.todCount,
        this.todAmount,
        this.todPerc,
        this.todDiffCount,
        this.todDiffAmount,
        this.todDiffPerc,
        this.lastBucketPortofolioPerc,
        this.bucketPortofolioPerc,
        this.bucketPortofolioDiffPerc,
        this.bal30upLastBucketAmount,
        this.bal30upLastBucketCount,
        this.bal30upLastBucketPerc,
        this.bal30upBucketAmount,
        this.bal30upBucketCount,
        this.bal30upBucketPerc,
        this.bal30upBucketDiffAmount,
        this.bal30upBucketDiffCount,
        this.bal30upBucketDiffPerc,
        this.bal60upLastBucketAmount,
        this.bal60upLastBucketCount,
        this.bal60upLastBucketPerc,
        this.bal60upBucketAmount,
        this.bal60upBucketCount,
        this.bal60upBucketPerc,
        this.bal60upBucketDiffAmount,
        this.bal60upBucketDiffCount,
        this.bal60upBucketDiffPerc,
        this.npl90upLastBucketAmount,
        this.npl90upLastBucketCount,
        this.npl90upLastBucketPerc,
        this.npl90upBucketAmount,
        this.npl90upBucketCount,
        this.npl90upBucketPerc,
        this.npl90upBucketDiffAmount,
        this.npl90upBucketDiffCount,
        this.npl90upBucketDiffPerc,
        this.branchName});

  factory CollectionModel.fromJson(Map<String, dynamic> json) {
    var b1_30c = (json['Bucket1_30Count'] as num).toDouble();
    var b31_60c = (json['Bucket31_60Count'] as num).toDouble();
    var b61_90c = (json['Bucket61_90Count'] as num).toDouble();
    var b91_120c = (json['Bucket91_120Count'] as num).toDouble();
    var b121_150c = (json['Bucket121_150Count'] as num).toDouble();
    var b151_180c = (json['Bucket151_180Count'] as num).toDouble();
    var b181_270c = (json['Bucket181_270Count'] as num).toDouble();
    var bUp270c = (json['Bucketup270Count'] as num).toDouble();

    var b1_30a = (json['Bucket1_30Amount'] as num).toDouble();
    var b31_60a = (json['Bucket31_60Amount'] as num).toDouble();
    var b61_90a = (json['Bucket61_90Amount'] as num).toDouble();
    var b91_120a = (json['Bucket91_120Amount'] as num).toDouble();
    var b121_150a = (json['Bucket121_150Amount'] as num).toDouble();
    var b151_180a = (json['Bucket151_180Amount'] as num).toDouble();
    var b181_270a = (json['Bucket181_270Amount'] as num).toDouble();
    var bUp270a = (json['Bucketup270Amount'] as num).toDouble();

    var b1_30p = (json['Bucket1_30Perc'] as num).toDouble();
    var b31_60p = (json['Bucket31_60Perc'] as num).toDouble();
    var b61_90p = (json['Bucket61_90Perc'] as num).toDouble();
    var b91_120p = (json['Bucket91_120Perc'] as num).toDouble();
    var b121_150p = (json['Bucket121_150Perc'] as num).toDouble();
    var b151_180p = (json['Bucket151_180Perc'] as num).toDouble();
    var b181_270p = (json['Bucket181_270Perc'] as num).toDouble();
    var bUp270p = (json['Bucketup270Perc'] as num).toDouble();

    var lb1_30c = (json['LastBucket1_30Count'] as num).toDouble();
    var lb31_60c = (json['LastBucket31_60Count'] as num).toDouble();
    var lb61_90c = (json['LastBucket61_90Count'] as num).toDouble();
    var lb91_120c = (json['LastBucket91_120Count'] as num).toDouble();
    var lb121_150c = (json['LastBucket121_150Count'] as num).toDouble();
    var lb151_180c = (json['LastBucket151_180Count'] as num).toDouble();
    var lb181_270c = (json['LastBucket181_270Count'] as num).toDouble();
    var lbUp270c = (json['LastBucketup270Count'] as num).toDouble();

    var lb1_30a = (json['LastBucket1_30Amount'] as num).toDouble();
    var lb31_60a = (json['LastBucket31_60Amount'] as num).toDouble();
    var lb61_90a = (json['LastBucket61_90Amount'] as num).toDouble();
    var lb91_120a = (json['LastBucket91_120Amount'] as num).toDouble();
    var lb121_150a = (json['LastBucket121_150Amount'] as num).toDouble();
    var lb151_180a = (json['LastBucket151_180Amount'] as num).toDouble();
    var lb181_270a = (json['LastBucket181_270Amount'] as num).toDouble();
    var lbUp270a = (json['LastBucketup270Amount'] as num).toDouble();

    var lb1_30p = (json['LastBucket1_30Perc'] as num).toDouble();
    var lb31_60p = (json['LastBucket31_60Perc'] as num).toDouble();
    var lb61_90p = (json['LastBucket61_90Perc'] as num).toDouble();
    var lb91_120p = (json['LastBucket91_120Perc'] as num).toDouble();
    var lb121_150p = (json['LastBucket121_150Perc'] as num).toDouble();
    var lb151_180p = (json['LastBucket151_180Perc'] as num).toDouble();
    var lb181_270p = (json['LastBucket181_270Perc'] as num).toDouble();
    var lbUp270p = (json['LastBucketup270Perc'] as num).toDouble();

    var bd1_30a = (json['Bucket1_30DiffAmount'] as num).toDouble();
    var bd31_60a = (json['Bucket31_60DiffAmount'] as num).toDouble();
    var bd61_90a = (json['Bucket61_90DiffAmount'] as num).toDouble();
    var bd91_120a = (json['Bucket91_120DiffAmount'] as num).toDouble();
    var bd121_150a = (json['Bucket121_150DiffAmount'] as num).toDouble();
    var bd151_180a = (json['Bucket151_180DiffAmount'] as num).toDouble();
    var bd181_270a = (json['Bucket181_270DiffAmount'] as num).toDouble();
    var bdUp270a = (json['Bucketup270DiffAmount'] as num).toDouble();

    var bd1_30c = (json['Bucket1_30DiffCount'] as num).toDouble();
    var bd31_60c = (json['Bucket31_60DiffCount'] as num).toDouble();
    var bd61_90c = (json['Bucket61_90DiffCount'] as num).toDouble();
    var bd91_120c = (json['Bucket91_120DiffCount'] as num).toDouble();
    var bd121_150c = (json['Bucket121_150DiffCount'] as num).toDouble();
    var bd151_180c = (json['Bucket151_180DiffCount'] as num).toDouble();
    var bd181_270c = (json['Bucket181_270DiffCount'] as num).toDouble();
    var bdUp270c = (json['Bucketup270DiffCount'] as num).toDouble();

    var bd1_30p = (json['Bucket1_30DiffPerc'] as num).toDouble();
    var bd31_60p = (json['Bucket31_60DiffPerc'] as num).toDouble();
    var bd61_90p = (json['Bucket61_90DiffPerc'] as num).toDouble();
    var bd91_120p = (json['Bucket91_120DiffPerc'] as num).toDouble();
    var bd121_150p = (json['Bucket121_150DiffPerc'] as num).toDouble();
    var bd151_180p = (json['Bucket151_180DiffPerc'] as num).toDouble();
    var bd181_270p = (json['Bucke181_270DiffPerc'] as num).toDouble();
    var bdUp270p = (json['Bucketup270DiffPerc'] as num).toDouble();

    var todlbp = (lb1_30p +
        lb31_60p +
        lb61_90p +
        lb91_120p +
        lb121_150p +
        lb151_180p +
        lb181_270p +
        lbUp270p);
    var todbp = (b1_30p +
        b31_60p +
        b61_90p +
        b91_120p +
        b121_150p +
        b151_180p +
        b181_270p +
        bUp270p);

    var todbdp = (bd1_30p +
        bd31_60p +
        bd61_90p +
        bd91_120p +
        bd121_150p +
        bd151_180p +
        bd181_270p +
        bdUp270p);

    var todlbc = (lb1_30c +
        lb31_60c +
        lb61_90c +
        lb91_120c +
        lb121_150c +
        lb151_180c +
        lb181_270c +
        lbUp270c);

    var todbc = (b1_30c +
        b31_60c +
        b61_90c +
        b91_120c +
        b121_150c +
        b151_180c +
        b181_270c +
        bUp270c);

    var toddc = (bd1_30c +
        bd31_60c +
        bd61_90c +
        bd91_120c +
        bd121_150c +
        bd151_180c +
        bd181_270c +
        bdUp270c);

    var todlba = (lb1_30a +
        lb31_60a +
        lb61_90a +
        lb91_120a +
        lb121_150a +
        lb151_180a +
        lb181_270a +
        lbUp270a);

    var todba = (b1_30a +
        b31_60a +
        b61_90a +
        b91_120a +
        b121_150a +
        b151_180a +
        b181_270a +
        bUp270a);

    var todda = (bd1_30a +
        bd31_60a +
        bd61_90a +
        bd91_120a +
        bd121_150a +
        bd151_180a +
        bd181_270a +
        bdUp270a);

    var cp = (json['CurrentPerc'] as num).toDouble();
    var lcp = (json['LastCurrentPerc'] as num).toDouble();
    var cdp = (json['CurrentDiffPerc'] as num).toDouble();

    var cc = (json['CurrentCount'] as num).toDouble();
    var lcc = (json['LastCurrentCount'] as num).toDouble();
    var cdc = (json['CurrentDiffCount'] as num).toDouble();

    var ca = (json['CurrentAmount'] as num).toDouble();
    var lca = (json['LastCurrentAmount'] as num).toDouble();
    var cda = (json['CurrentDiffAmount'] as num).toDouble();

    return CollectionModel(
      branchName: (json['branchName'] as String),
      portofolioAmount: (json['PortofolioAmount'] as num).toDouble(),
      portofolioCount: (json['PortofolioCount'] as num).toDouble(),
      lastPortofolioAmount: (json['LastPortofolioAmount'] as num).toDouble(),
      lastPortofolioCount: (json['LastPortofolioCount'] as num).toDouble(),
      portofolioAmountDiff: (json['PortfolioAmountDiff'] as num).toDouble(),
      portofolioCountLastDiff:
      (json['PortfolioCountLastDiff'] as num).toDouble(),
      currentAmount: ca,
      currentCount: cc,
      currentPerc: cp,
      lastCurrentAmount: lca,
      lastCurrentCount: lcc,
      lastCurrentPerc: lcp,
      currentDiffAmount: cda,
      currentDiffCount: cdc,
      currentDiffPerc: cdp,
      bucket1_30Amount: b1_30a,
      bucket1_30Count: b1_30c,
      bucket1_30Perc: b1_30p,
      lastBucket1_30Amount: lb1_30a,
      lastBucket1_30Count: lb1_30c,
      lastBucket1_30Perc: lb1_30p,
      bucket1_30DiffAmount: bd1_30a,
      bucket1_30DiffCount: bd1_30c,
      bucket1_30DiffPerc: bd1_30p,
      bucket31_60Amount: b31_60a,
      bucket31_60Count: b31_60c,
      bucket31_60Perc: b31_60p,
      lastBucket31_60Amount: lb31_60a,
      lastBucket31_60Count: lb31_60c,
      lastBucket31_60Perc: lb31_60p,
      bucket31_60DiffAmount: bd31_60a,
      bucket31_60DiffCount: bd31_60c,
      bucket31_60DiffPerc: bd31_60p,
      bucket61_90Amount: b61_90a,
      bucket61_90Count: b61_90c,
      bucket61_90Perc: b61_90p,
      lastBucket61_90Amount: lb61_90a,
      lastBucket61_90Count: lb61_90c,
      lastBucket61_90Perc: lb61_90p,
      bucket61_90DiffAmount: bd61_90a,
      bucket61_90DiffCount: bd61_90c,
      bucket61_90DiffPerc: bd61_90p,
      bucket91_120Amount: b91_120a,
      bucket91_120Count: b91_120c,
      bucket91_120Perc: b91_120p,
      lastBucket91_120Amount: lb91_120a,
      lastBucket91_120Count: lb91_120c,
      lastBucket91_120Perc: lb91_120p,
      bucket91_120DiffAmount: bd91_120a,
      bucket91_120DiffCount: bd91_120c,
      bucket91_120DiffPerc: bd91_120p,
      bucket121_150Amount: b121_150a,
      bucket121_150Count: b121_150c,
      bucket121_150Perc: b121_150p,
      lastBucket121_150Amount: lb121_150a,
      lastBucket121_150Count: lb121_150c,
      lastBucket121_150Perc: lb121_150p,
      bucket121_150DiffAmount: bd121_150a,
      bucket121_150DiffCount: bd121_150c,
      bucket121_150DiffPerc: bd121_150p,
      bucket151_180Amount: b151_180a,
      bucket151_180Count: b151_180c,
      bucket151_180Perc: b151_180p,
      lastBucket151_180Amount: lb151_180a,
      lastBucket151_180Count: lb151_180c,
      lastBucket151_180Perc: lb151_180p,
      bucket151_180DiffAmount: bd151_180a,
      bucket151_180DiffCount: bd151_180c,
      bucket151_180DiffPerc: bd151_180p,
      bucket181_270Amount: b181_270a,
      bucket181_270Count: b181_270c,
      bucket181_270Perc: b181_270p,
      lastBucket181_270Amount: lb181_270a,
      lastBucket181_270Count: lb181_270c,
      lastBucket181_270Perc: lb181_270p,
      bucket181_270DiffAmount: bd181_270a,
      bucket181_270DiffCount: bd181_270c,
      bucket181_270DiffPerc: bd181_270p,
      bucketUpTo270Amount: bUp270a,
      bucketUpTo270Count: bUp270c,
      bucketUpTo270Perc: bUp270p,
      lastBucketUpTo270Amount: lbUp270a,
      lastBucketUpTo270Count: lbUp270c,
      lastBucketUpTo270Perc: lbUp270p,
      bucketUpTo270DiffAmount: bdUp270a,
      bucketUpTo270DiffCount: bdUp270c,
      bucketUpTo270DiffPerc: bdUp270p,
      bucketWOAmount: (json['BucketWoAmount'] as num).toDouble(),
      bucketWOCount: (json['BucketWoCount'] as num).toDouble(),
      bucketWOPerc: (json['BucketWoPerc'] as num).toDouble(),
      lastBucketWOAmount: (json['LastBucketWoAmount'] as num).toDouble(),
      lastBucketWOCount: (json['LastBucketWoCount'] as num).toDouble(),
      lastBucketWOPerc: (json['LastBucketWoPerc'] as num).toDouble(),
      bucketWODiffAmount: (json['BucketWoDiffAmount'] as num).toDouble(),
      bucketWODiffCount: (json['BucketWoDiffCount'] as num).toDouble(),
      bucketWODiffPerc: (json['BucketWoDiffPerc'] as num).toDouble(),
      todLastBucketCount: todlbc,
      todLastBucketAmount: todlba,
      todLastBucketPerc: todlbp,
      todAmount: todba,
      todCount: todbc,
      todPerc: todbp,
      todDiffAmount: todda,
      todDiffCount: toddc,
      todDiffPerc: todbdp,
      lastBucketPortofolioPerc: lcp + todlbp,
      bucketPortofolioPerc: cp + todbp,
      bucketPortofolioDiffPerc: cdp + todbdp,
      bal30upLastBucketCount: todlbc - lb1_30c,
      bal30upLastBucketAmount: todlba - lb1_30a,
      bal30upLastBucketPerc: todlbp - lb1_30p,
      bal30upBucketCount: todbc - b1_30c,
      bal30upBucketAmount: todba - b1_30a,
      bal30upBucketPerc: todbp - b1_30p,
      bal30upBucketDiffCount: toddc - bd1_30c,
      bal30upBucketDiffAmount: todda - bd1_30a,
      bal30upBucketDiffPerc: todbdp - bd1_30p,
      bal60upLastBucketCount: todlbc - (lb1_30c + lb31_60c),
      bal60upLastBucketAmount: todlba - (lb1_30a + lb31_60a),
      bal60upLastBucketPerc: todlbp - (lb1_30p + lb31_60p),
      bal60upBucketCount: todbc - (b1_30c + b31_60c),
      bal60upBucketAmount: todba - (b1_30a + b31_60a),
      bal60upBucketPerc: todbp - (b1_30p + b31_60p),
      bal60upBucketDiffCount: toddc - (bd1_30c + bd31_60c),
      bal60upBucketDiffAmount: todda - (bd1_30a + bd31_60a),
      bal60upBucketDiffPerc: todbdp - (bd1_30p + bd31_60p),
      npl90upLastBucketCount: todlbc - (lb1_30c + lb31_60c + lb61_90c),
      npl90upLastBucketAmount: todlba - (lb1_30a + lb31_60a + lb61_90a),
      npl90upLastBucketPerc: todlbp - (lb1_30p + lb31_60p + lb61_90p),
      npl90upBucketCount: todbc - (b1_30c + b31_60c + b61_90c),
      npl90upBucketAmount: todba - (b1_30a + b31_60a + b61_90a),
      npl90upBucketPerc: todbp - (b1_30p + b31_60p + b61_90p),
      npl90upBucketDiffCount: toddc - (bd1_30c + bd31_60c + bd61_90c),
      npl90upBucketDiffAmount: todda - (bd1_30a + bd31_60a + bd61_90a),
      npl90upBucketDiffPerc: todbdp - (bd1_30p + bd31_60p + bd61_90p),
    );
  }
}