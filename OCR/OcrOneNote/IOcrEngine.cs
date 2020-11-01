using System;
using System.Drawing;
using System.Linq;

namespace ECMLibraryOCR
{
    public interface IOcrEngine
    {
        string Recognize(Image image);
    }
}