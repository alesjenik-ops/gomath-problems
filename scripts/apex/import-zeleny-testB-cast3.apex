String SRC   = 'Matematika - Zelený';
String STYPE = 'Jiné';

public class C {
  Map<String,Id> tx; Set<String> have; String src; String stype; public Integer created=0;
  C(Map<String,Id> tx, Set<String> have, String src, String stype){this.tx=tx;this.have=have;this.src=src;this.stype=stype;}
  Id sv(String t,String fn,String s){ContentVersion cv=new ContentVersion(Title=t,PathOnClient=fn,VersionData=Blob.valueOf(s),Origin='H');insert cv;return [SELECT ContentDocumentId FROM ContentVersion WHERE Id=:cv.Id].ContentDocumentId;}
  void lk(Id d,Id r){try{insert new ContentDocumentLink(ContentDocumentId=d,LinkedEntityId=r,ShareType='V',Visibility='AllUsers');}catch(Exception e){insert new ContentDocumentLink(ContentDocumentId=d,LinkedEntityId=r,ShareType='V',Visibility='InternalUsers');}}
  String para(String t){return '{"type":"paragraph","text":'+JSON.serialize(t)+'}';}
  String content(List<String> zad, Id d, String alt, String cap, List<String> opts, Integer ln){
    String s='{"schemaVersion":1,"blocks":[';
    for(Integer i=0;i<zad.size();i++){if(i>0)s+=',';s+=para(zad[i]);}
    if(d!=null){s+=',{"type":"image","contentDocumentId":"'+d+'","alt":'+JSON.serialize(alt)+',"caption":'+JSON.serialize(cap)+',"widthPercent":75,"align":"center"}';}
    if(opts!=null && !opts.isEmpty()){s+=',{"type":"list","items":[';for(Integer i=0;i<opts.size();i++){if(i>0)s+=',';s+=JSON.serialize(opts[i]);}s+=']}';}
    if(ln!=null && ln>0){s+=',{"type":"answerSpace","lines":'+ln+'}';}
    s+=']}';return s;
  }
  String solution(List<String> ps){String s='{"schemaVersion":1,"blocks":[';for(Integer i=0;i<ps.size();i++){if(i>0)s+=',';s+=para(ps[i]);}s+=']}';return s;}
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
    insert pub;
    List<Problem_Taxon__c> ls=new List<Problem_Taxon__c>();
    for(String code:codes){Id ti=tx.get(code);if(ti==null)continue;ls.add(new Problem_Taxon__c(Problem_Version__c=pub.Id,Taxon__c=ti,Unique_Key__c=pub.Id+'_'+ti));}
    if(!ls.isEmpty())insert ls;
    if(d!=null)lk(d,mp.Id);
    created++;
  }
}
Map<String,Id> tx=new Map<String,Id>();
for(Taxon__c t:[SELECT Id,Code__c FROM Taxon__c])tx.put(t.Code__c,t.Id);
Set<String> have=new Set<String>();
for(Math_Problem__c p:[SELECT Name FROM Math_Problem__c])have.add(p.Name);
C c=new C(tx,have,SRC,STYPE);

c.add(
  'Zelený B9 – množina bodů stejně vzdálených od p a q',
  new List<String>{'V rovině leží přímky $p$ a $q$, které spolu svírají úhel $60^\\circ$.','Vyznačte množinu bodů, jejichž vzdálenost od přímky $p$ i od přímky $q$ je stejná.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 340" font-family="sans-serif"> <line x1="30" y1="200" x2="430" y2="200" stroke="#000" stroke-width="2"/> <text x="438" y="205" font-size="18" font-style="italic">p</text> <line x1="168" y1="308" x2="292" y2="92" stroke="#000" stroke-width="2"/> <text x="298" y="90" font-size="18" font-style="italic">q</text> <path d="M 290 200 A 60 60 0 0 0 260 148" fill="none" stroke="#000" stroke-width="1.2"/> <text x="256" y="184" font-size="17" text-anchor="middle">60°</text> </svg>',
  'primky-p-q.svg',
  'Dvě různoběžné přímky p a q svírající úhel 60°.',
  'Výchozí obrázek k úloze 9',
  new List<String>{'Množinou bodů stejně vzdálených od dvou různoběžek jsou obě osy úhlů, které přímky $p$ a $q$ svírají. Tyto dvě osy ($o_1$, $o_2$) procházejí průsečíkem přímek a jsou na sebe kolmé (viz klíč).'},
  'Dvě navzájem kolmé osy úhlů ($o_1$, $o_2$) sevřených přímkami $p$ a $q$, procházející jejich průsečíkem.',
  2, 6, '3',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený B10 – konstrukce trojúhelníku z těžnic',
  new List<String>{'Na přímce $t_c$ je vyznačena úsečka $CS_c$ o délce $9$ cm.','Sestrojte trojúhelník $ABC$, jehož strana $c=8$ cm, úsečka $CS_c$ je jeho jednou těžnicí a druhá těžnice $t_b=6$ cm.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 120" font-family="sans-serif"> <line x1="40" y1="65" x2="420" y2="65" stroke="#000" stroke-width="2"/> <text x="230" y="40" font-size="17" font-style="italic" text-anchor="middle">t</text> <text x="240" y="46" font-size="12" font-style="italic">c</text> <line x1="95" y1="52" x2="95" y2="78" stroke="#000" stroke-width="2"/> <line x1="375" y1="52" x2="375" y2="78" stroke="#000" stroke-width="2"/> <text x="90" y="100" font-size="18" font-weight="bold">C</text> <text x="368" y="100" font-size="18" font-weight="bold">S</text> <text x="382" y="104" font-size="12">c</text> </svg>',
  'teznice-tc.svg',
  'Přímka t_c s vyznačenou úsečkou CS_c o délce 9 cm, krajní body C a S_c.',
  'Výchozí obrázek k úloze 10',
  new List<String>{'Těžiště $T$ dělí těžnici $CS_c$ v poměru $2:1$ od vrcholu, tedy $|CT|=6$ cm, $|TS_c|=3$ cm. Bod $S_c$ je střed strany $AB$; sestrojíme $A$ a $B$ tak, aby $|AB|=8$ cm a $S_c$ byl jejich střed (kolmice k $CS_c$ v bodě $S_c$, na ní $|S_cA|=|S_cB|=4$ cm nebude obecně, proto využijeme těžnici $t_b$). Z bodu $B$ vede těžnice $t_b=6$ cm do středu strany $b$; body upravíme tak, aby $T$ ležel i na $t_b$ ve vzdálenosti $\\frac{2}{3}\\cdot 6=4$ cm od $B$. Spojením $A$, $B$, $C$ vznikne hledaný trojúhelník (viz klíč).'},
  'Konstrukce trojúhelníku $ABC$ s $|AB|=8$ cm, těžnicí $CS_c=9$ cm a těžnicí $t_b=6$ cm (těžiště $T$ dělí těžnice v poměru $2:1$); viz obrázek v klíči.',
  2, 6, '3',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený B11 – karetní hra (Ano/Ne)',
  new List<String>{'Spolužáci hrají hru o to, kdo bude mít na konci nejvíc karet. Na začátku hry se všechny karty rozdají, proto měli Petr, Martin, Jana a Eva po osmi kartách. V průběhu hry se žádné karty neodkládají. V polovině hry na tom byli Petr i Martin stejně, zatímco Eva měla o polovinu víc než oba chlapci dohromady. Jana ztratila během první poloviny hry tři čtvrtiny karet.','Rozhodněte o každém z následujících tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).','11.1 Dívky měly po polovině hry o třetinu víc karet než chlapci.','11.2 Petr přišel v první polovině hry o polovinu karet.','11.3 Když Eva v druhé polovině hry neztratí víc než jednu kartu, vyhraje.'},
  null,
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Celkem je $4\\cdot 8=32$ karet. Jana má $8\\cdot\\frac{1}{4}=2$ karty. Petr $=$ Martin $=p$, Eva $=\\frac{3}{2}\\cdot 2p=3p$. Z rovnice $p+p+3p+2=32$ plyne $p=6$: Petr $6$, Martin $6$, Eva $18$, Jana $2$.','11.1 Dívky $18+2=20$, chlapci $6+6=12$. O třetinu víc by bylo $16$, ale je to $20$ (o dvě třetiny víc). Nepravda — Ne.','11.2 Petr má $6$ z původních $8$, ztratil $2$ karty, tj. $\\frac{1}{4}$, nikoli polovinu. Ne.','11.3 Eva má $18$; ztratí-li nejvýš $1$, má aspoň $17$. Ostatní mají dohromady nejvýš $15$, takže nikdo nemá víc než ona. Ano.'},
  '11.1: Ne; 11.2: Ne; 11.3: Ano',
  3, 7, '3',
  new List<String>{'zs2','r9','statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
